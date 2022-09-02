import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late MqttServerClient client;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = MqttServerClient.withPort('mqqt.call4help.uk', 'mqttx_50931b1f', 1883);
  }


  Future<MqttServerClient> connect() async {
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    //client.onUnsubscribed = onUnsubscribed as UnsubscribeCallback?;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs('2012000099', 'A9PhwtzX')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect("2012000099","A9PhwtzX");
      print("connected ${client.onConnected}");
      await client.subscribe("/2012000099/#", MqttQos.atLeastOnce);
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttMessage message = c[0].payload;
      //final payload = MqttPublishPayload.bytesToStringAsString(message.toString());

      print('Received message: from topic: ${c[0].topic}> ${message.header.toString()}');
    });

    return client;
  }

  // connection succeeded
  void onConnected() {
    print('-------->Connected');
  }

// unconnected
  void onDisconnected() {
    print('------->Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('-------->Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('------->Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('------->Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('------->Ping response client callback invoked');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("MQTT Test"),
            TextButton(onPressed: ()async{
              client = await connect();
            }, child: Text("Connect")),
            TextButton(onPressed: (){
              client.subscribe("/2012000099/#", MqttQos.atLeastOnce);
            }, child: Text("Subscribe")),
            TextButton(onPressed: (){
              final builder = MqttClientPayloadBuilder();
              builder.addString('Hello MQTT');
              client.publishMessage("/2012000099/#", MqttQos.atLeastOnce, builder.payload!);
            }, child: Text("Publish")),
            TextButton(onPressed: (){
              client.unsubscribe("/2012000099/#");
            }, child: Text("Unsubscribe")),
            TextButton(onPressed: (){
              client.disconnect();
            }, child: Text("Disconnect")),
          ],
        ),
      ),
    );
  }
}
