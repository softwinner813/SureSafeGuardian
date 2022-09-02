
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/model/login/login_response.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/screens/dashboard/dashboard_widget.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttProviderNew {
  MqttProviderNew._();

  var service;

  MqttProviderNew(FlutterBackgroundService backgroundService) {
    this.service = backgroundService;
  }

  static final MqttProviderNew mqtt = MqttProviderNew._();

  MqttServerClient? _client;

  Future<MqttServerClient?> get client async {
    print("_client ${_client}");
    if (_client != null) return _client;
    // if _database is null we instantiate it
    _client = await init();
    return _client;
  }

  init() async {
    print("Mqtt : init");

    _client = (await MqttServerClient.withPort(
        "mqqt.call4help.uk", "mqtt_2012000008", 1883));
    await connect();
    // await subscribe("2012000008");
    // await updateListner();
    return LoginResponse(status: true, message: "Connected");
  }

  connect() async {
    print("Mqtt : connect");
    _client?.logging(on: true);
    _client?.onConnected = onConnected;
    _client?.onDisconnected = onDisconnected;
    //_client?.onUnsubscribed = onUnsubscribed as UnsubscribeCallback?;
    _client?.onSubscribed = onSubscribed;
    _client?.onSubscribeFail = onSubscribeFail;
    _client?.pongCallback = pong;
    _client?.autoReconnect = true;

    final connMessage = MqttConnectMessage()
        .authenticateAs("2012000008", "7TMnjUh3")
    //.keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
    // .startClean()
        .withClientIdentifier(_client?.clientIdentifier ?? "")
        .withWillQos(MqttQos.atLeastOnce);
    _client?.connectionMessage = connMessage;

    try {
      await _client?.connect("2012000008", "7TMnjUh3");
      print("connected ${_client?.onConnected}");
      print("client details -----> ${_client?.clientIdentifier}");
      await subscribe("2012000008");
      await updateListner();
      return LoginResponse(status: true, message: "Connected");
    } catch (e) {
      print('Exception: $e');
    }
  }

  subscribe(String topic) async {
    try {
      await _client?.subscribe("/$topic/#", MqttQos.exactlyOnce);
    } catch (e) {
      print('Exception: $e');
    }
  }

  unsubscribe(String topic) async {
    try {
      _client?.unsubscribe("/$topic/#");
    } catch (e) {
      print('Exception: $e');
    }
  }

  updateListner() async {
    try {
      _client?.updates?.listen((List<MqttReceivedMessage> c) async{
        //if (c[0].topic.contains(userId)) {
        final MqttPublishMessage message = c[0].payload;
        String switchstate =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print("Received message: from topic: ${c[0].topic}>  Message " +
            switchstate);

        List<String> list = switchstate.split(",");
        Map<String, dynamic> map = Map();
        list.forEach((element) {
          map[element.split(":").first] = element.split(":").last;
        });
        print("data map ${map.toString()}");
        //await DBProvider.db.newEventAdded(MqttEvent.fromJson(map));
        FlutterBackgroundService().sendData({
          "username": switchstate,
          "mqtt": switchstate,
        });
        FlutterBackgroundService().setNotificationInfo(
          title: "${map.toString()}",
          content: "Updated at ${DateTime.now()}",
        );
      });
      return LoginResponse(status: true, message: "Connected");
    } catch (e) {}
  }

  disconnect() async {
    try {
      _client?.disconnect();
    } catch (e) {
      print('Exception: $e');
    }
  }

  void onConnected() {
    print("connected...........->");
  }

  void onDisconnected() {
    print("onDisconnected...........->");
  }

  void onSubscribed(String topic) {
    print("onSubscribed...........->");
  }

  void onSubscribeFail(String topic) {
    print("onSubscribeFail...........->");
  }

  void pong() {
    print("pong...........->");
  }
}
