import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/model/login/login_response.dart';
import 'package:guardian/data/model/mqtt/MedicineReminder.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttProvider.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/screens/components/notification/notification_manager.dart';
import 'package:guardian/screens/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import '../main.dart';
import 'api/ApiProvider.dart';
import 'constansts.dart';
import 'local/DBProvider.dart';
import 'model/mqtt/mqtt_event.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();
  MqttProvider mqttProvider = MqttProvider.mqtt;

  Future<LoginResponse> loginUser(
      BuildContext context, LoginRequest request) async {
    final response = await mqttProvider.connect(request);
    return response;
  }

  Future<bool> logout() async {
    String username = await getUserName();
    await mqttProvider.unsubscribe(username);
    final response = await mqttProvider.disconnect();
    return true;
  }



  mqttDataUpdated(BuildContext context, MqttEvent event) async {
    print("mqtt updating");
    await DBProvider.db.newEventAdded(event);
    List<MqttEvent> list = await DBProvider.db.getAllEvent();
    print("list -- ${list.length}");
    if (event.event == "mqtt") {
      Provider.of<MqttNotifier>(context, listen: false).updateMqtt(event);
    } else if (event.event == "temp") {
      Provider.of<MqttNotifier>(context, listen: false).updateTemp(event);
    } else if (event.event == "ess") {
      Provider.of<MqttNotifier>(context, listen: false).updateEss(event);
      Provider.of<MqttNotifier>(context, listen: false).updateUsername(event);
    } else if (event.event == "ethernet") {
      Provider.of<MqttNotifier>(context, listen: false).updateEthernet(event);
    }else if (event.event == "iamlife") {
      event.status = "1";
      Provider.of<MqttNotifier>(context, listen: false).updatePir(event);
      Provider.of<MqttNotifier>(context, listen: false).updatePirDuration((await getMqttPirInActiveDuration(context)));
    }else if (event.event == "battery") {
      Provider.of<MqttNotifier>(context, listen: false).updateBattery(event);
    }else if (event.event == "button") {
      Provider.of<MqttNotifier>(context, listen: false).updatePower(event);
    }else if (event.event == "homeaway") {
      Provider.of<MqttNotifier>(context, listen: false).updateHomeAway(event);
    }else if (event.event == "firmware") {
      Provider.of<MqttNotifier>(context, listen: false).updateFireware(event);
    }else if(event.event == "ast"){
      Provider.of<MqttNotifier>(context, listen: false).alarmActivityManage(event);
      Provider.of<MqttNotifier>(context, listen: false).updateUsername(event);
    }else if(event.event == "ruok"){
      Provider.of<MqttNotifier>(context, listen: false).ruokCheck();
    } else if(event.event == "medication"){
      Provider.of<MqttNotifier>(context, listen: false).medicationEvent();
    }
  }

  mqttDataLocal(BuildContext context) async {
    List<MqttEvent> list = await DBProvider.db.getAllEvent();
    print("list -- ${list.length}");

    MqttEvent? mqttEvent = await getMqttMqtt(context);
    Provider.of<MqttNotifier>(context, listen: false).updateMqtt(mqttEvent);
    MqttEvent? mqttTemp = await getMqttTemp(context);
    Provider.of<MqttNotifier>(context, listen: false).updateTemp(mqttTemp);
    MqttEvent? mqttEss = await getMqttEss(context);
    Provider.of<MqttNotifier>(context, listen: false).updateEss(mqttEss);
    MqttEvent? mqttUsername = await DBProvider.db.getUsername();
    Provider.of<MqttNotifier>(context, listen: false).updateUsername(mqttUsername);
    MqttEvent? mqttEthernet = await getMqttEthernet(context);
    Provider.of<MqttNotifier>(context, listen: false).updateEthernet(mqttEthernet);
    MqttEvent? mqttPir = await getMqttPir(context);
    if(mqttPir?.event == "iamlife"){
      mqttPir?.status = "1";
    }
    Provider.of<MqttNotifier>(context, listen: false).updatePir(mqttPir);
    MqttEvent? mqttBattery = await getMqttBattery(context);
    Provider.of<MqttNotifier>(context, listen: false).updateBattery(mqttBattery);
    MqttEvent? mqttPower = await getMqttPower(context);
    Provider.of<MqttNotifier>(context, listen: false).updatePower(mqttPower);
    MqttEvent? mqttHomeAway = await getMqttHomeAway();
    Provider.of<MqttNotifier>(context, listen: false).updateHomeAway(mqttHomeAway);
    Provider.of<MqttNotifier>(context, listen: false).updatePirDuration((await getMqttPirInActiveDuration(context)));
    MqttEvent? mqttFireware = await getMqttFireware(context);
    Provider.of<MqttNotifier>(context, listen: false).updateFireware(mqttFireware);
    Provider.of<MqttNotifier>(context, listen: false).ruokCheck();
    Provider.of<MqttNotifier>(context, listen: false).medicationEvent();

    //night time exceed detection
    Provider.of<MqttNotifier>(context, listen: false).nightTimeExceedManage();
    Provider.of<MqttNotifier>(context, listen: false).wakeTimeExceedManage();

  }

  // connection succeeded
  void onConnected() async{
    print('-------->Connected');
    saveMqttStatus("connected");

    NotificationManger().cancelNotification(2111);
  }

  // unconnected
  void onDisconnected() async{
    print('------->Disconnected');
    saveMqttStatus("disconnected");
    NotificationManger().displayNotification(2111, "Alert ", "App disconnected from ess, please login again");
    // bool? isLogin = await getLogin();
    // if(isLogin == true){
    //   String username = await getUserName();
    //   String password = await getUserPassword();
    //   await mqttProvider.connect(LoginRequest(username: username,password: password));
    // }

  }

  // subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('-------->Subscribed topic: $topic');
    saveMqttStatus("subscribed");
  }

  // subscribe to topic failed
  void onSubscribeFail(String topic) {
    saveMqttStatus("onSubscribeFail");
    print('------->Failed to subscribe $topic');
  }

  // unsubscribe succeeded
  void onUnsubscribed(String topic) {
    saveMqttStatus("onUnsubscribed");
    print('------->Unsubscribed topic: $topic');
  }

  // PING response received
  void pong() {
    print('------->Ping response client callback invoked');
  }

  Future<MqttEvent?> getMqttEss(BuildContext context) async {
    try {
      return (await DBProvider.db.getEvent("ess"));
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttTemp(BuildContext context) async {
    try {
      return (await DBProvider.db.getEvent("temp"));
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttRuok(BuildContext context) async {
    try {
      return (await DBProvider.db.getEvent("ruok"));
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttEthernet(BuildContext context) async {
    try {
      MqttEvent? mqttEthernet = await DBProvider.db.getEvent("ethernet");
      if (mqttEthernet == null) {
        mqttEthernet = await DBProvider.db.getEventLat();
        //mqttPower?.status == "";
        return mqttEthernet;
      } else {
        return mqttEthernet;
      }
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttFireware(BuildContext context) async {
    try {
      return (await DBProvider.db.getEvent("firmware"));
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttBattery(BuildContext context) async {
    try {
      return (await DBProvider.db.getEvent("battery"));
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttMqtt(BuildContext context) async {
    try {
      return (await DBProvider.db.getEvent("mqtt"));
    }catch(e){

    }
  }

  Future<MqttEvent?> getMqttPir(BuildContext context) async {
    try {
      return (await DBProvider.db.getLastPir());
    }catch(e){

    }
  }
  Future<MqttEvent?> getMqttPower(BuildContext context) async {
    //return await DBProvider.db.getEvent("button");
    try {
      MqttEvent? mqttPower = await DBProvider.db.getEvent("button");
      if (mqttPower == null) {
        mqttPower = await DBProvider.db.getEventLat();
        //mqttPower?.status == "";
        return mqttPower;
      } else {
        return mqttPower;
      }
    }catch(e){

    }
  }


  Future<MqttEvent?> getMqttHomeAway() async {
    try {
      return (await DBProvider.db.getEvent("homeaway"));
    }catch(e){
    }
  }


  Future<List<MqttEvent>> getMqttTempList(BuildContext context) async {
      return List.from(
          (await DBProvider.db.getAllEventFilter("temp")).reversed);

  }

  Future<List<MqttEvent>> getMqttRuokList(BuildContext context) async {
    return List.from(
        (await DBProvider.db.getAllEventFilter("ruok")).reversed);

  }

  Future<List<MqttEvent>> getMqttPirList(BuildContext context) async {
    return (await DBProvider.db.getAllEventPir());
  }

  Future<String> getMqttPirInActiveDuration(BuildContext context) async {

    MqttEvent? lastPir = await DBProvider.db.getLastPirActive();
    if(lastPir?.event == "pir" && lastPir?.status == "1") {
      return MqttUtils().calculateTimeDifferenceAgo(DateTime.now(),lastPir?.dateCreated);
    }
    return "0 min";
  }


  Future<List<MedicineReminder>> getAllMedicineReminder(BuildContext context) async {
    return (await DBProvider.db.getAllMedicineReminder());
  }

  Future<int?> addMedicineReminder(BuildContext context,MedicineReminder medicineReminder) async {
    int reminder = await DBProvider.db.getMedicationReminder(medicineReminder.id??0);
    int result = 0;
    if(reminder == 0){
      result = (await DBProvider.db.newMedicineReminderAdded(medicineReminder));
    }else{
      result =  (await DBProvider.db.updateMedicineReminderAdded(medicineReminder));
    }
    return result;
  }

  Future<int?> deleteMedicineReminder(BuildContext context,MedicineReminder medicineReminder) async {
    return (await DBProvider.db.deleteMedicineReminder(medicineReminder.id??0));
  }

  Future<int?> deleteAllMedicineReminder(BuildContext context,MedicineReminder medicineReminder) async {
    return (await DBProvider.db.deleteAllMedicineReminder());
  }


  Future<MqttEvent?> getMqttDial() async {
    return (await DBProvider.db.getEvent("dial"));
  }

  Future<List<MqttEvent>> getMqttdiallist(BuildContext context) async {
    return List.from(
        (await DBProvider.db.getAllEventFilter("dial")).reversed);

  }

  Future<List<MqttEvent>?> getAllAlarmCall(BuildContext context) async {
    return (await DBProvider.db.getAllAst());
  }


}
