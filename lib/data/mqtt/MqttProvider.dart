import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guardian/cubit/mqtt/MqttCubit.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/model/login/login_response.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/main.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

class MqttProvider {
  MqttProvider._();
  var service;
  static final MqttProvider mqtt = MqttProvider._();

  MqttServerClient? _client;


  MqttProvider(FlutterBackgroundService backgroundService) {
    this.service = backgroundService;
  }

  Future<MqttServerClient?> get client async {
    print("_client ${_client}");
    if (_client != null) return _client;
    // if _database is null we instantiate it
    _client = await init();
    return _client;
  }

  init() async {
    print("Mqtt : init");
    return (await  MqttServerClient.withPort(MQTT_SERVER, "mqtt_${getRandString(8)}", MQTT_PORT));
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }
  // initDelay(String uname,String pass)async{
  //   _client = await init(uname);
  //   print("username ${uname}");
  //   username = uname;
  //   password = pass;
  //   LoginRequest request = LoginRequest(username: username,password: password);
  //   await connect(request);
  //   await subscribe(username);
  //   await updateListner(username);
  // }

  connect(LoginRequest request)async{
    await MqttProvider.mqtt.client;
    if(_client != null) {
      print("Mqtt : connect");
      _client?.onConnected = Repository().onConnected;
      _client?.onDisconnected = Repository().onDisconnected;
      //_client?.onUnsubscribed = onUnsubscribed as UnsubscribeCallback?;
      _client?.onSubscribed = Repository().onSubscribed;
      _client?.onSubscribeFail = Repository().onSubscribeFail;
      _client?.pongCallback = Repository().pong;
      _client?.autoReconnect = true;
      _client?.logging(on: true);

      final connMessage = MqttConnectMessage()
          .authenticateAs(request.username, request.password)
          //.keepAliveFor(0)
          .withWillTopic('willtopic')
          .withWillMessage('Will message')
          .startClean()
         // .withClientIdentifier("mqtt_$username")
          .withWillQos(MqttQos.atLeastOnce);
      _client?.connectionMessage = connMessage;

      try {
        await _client?.connect(request.username, request.password);
        print("connected ${_client?.onConnected}");
        print("client details -----> ${_client?.clientIdentifier}");
        MqttProvider.mqtt.subscribe(request.username??"");
        MqttProvider.mqtt.updateListner(request.username??"");
        return LoginResponse(status: true, message: "Connected");
      } catch (e) {
        print('Exception: $e');
        return LoginResponse(status: false, message: e.toString());
      }
    }
  }

  subscribe(String topic)async{
    try {
      if(_client != null) {
        await _client?.subscribe("/$topic/#", MqttQos.atLeastOnce);
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  unsubscribe(String topic)async{
    try {
      _client?.unsubscribe("/$topic/#");
    } catch (e) {
      print('Exception: $e');
    }
  }


  updateListner(userId){
    print("update listner ...");
    try {
      if(_client != null) {
        _client?.updates?.listen((List<MqttReceivedMessage> c)  {
          print("message received ----> ${c[0].payload}");
          if (c[0].topic.contains(userId)) {
            final MqttPublishMessage message = c[0].payload;
            String switchstate =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
            print("Received message: from topic: ${c[0].topic}>  Message " +
                switchstate);

            List<String> list = switchstate.split(",");
            Map<String, dynamic> map = Map();
            list.forEach((element) {
              map[element
                  .split(":")
                  .first] = element
                  .split(":")
                  .last;
            });
            print("data map ${map.toString()}");
            DBProvider.db.newEventAdded(MqttEvent.fromJson(map));

            // FlutterBackgroundService().sendData({
            //   //"username": switchstate,
            //   "mqtt": map,
            // });
            // FlutterBackgroundService().setNotificationInfo(
            //   title: "${map.toString()}",
            //   content: "Updated at ${DateTime.now()}",
            // );
          }
        });
      }
    }catch(e){

    }
  }




  disconnect()async{
    try {
       _client?.disconnect();
    } catch (e) {
      print('Exception: $e');
    }
  }

}