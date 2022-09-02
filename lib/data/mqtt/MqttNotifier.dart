import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/components/notification/notification_manager.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

enum RuokStatus{
  noset,
  announcement1,
  announcement2,
  announcement3,
  announcement4,
  announcement5,
  acknowledged,
  noresponse
}

class MqttNotifier extends ChangeNotifier {
  MqttEvent? mqtt;
  MqttEvent? username;
  MqttEvent? ess;
  MqttEvent? temp;
  MqttEvent? ethernet;
  MqttEvent? pir;
  MqttEvent? battery;
  MqttEvent? power;
  MqttEvent? homeAway;
  MqttEvent? fireware;
  MqttEvent? ruok;
  MqttEvent? medication;
  RuokStatus? ruokStatus;
  RuokStatus? medicationStatus;
  bool? activityTimeExcceded = false;
  String lastPirInActiveDuration = "0 min Ago";
  StopWatchTimer stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp); // Create instance.
  Timer? timerActivity;
  Timer? timerUserAway;
  Timer? timerPirOutRange;
  Timer? timerNightExceed;
  Timer? timerLackOfMoment;
  Timer? timerGuardianNetwork;
  Timer? timerPower;
  Timer? timerInternetLost;
  Timer? timerFirewareUpdate;
  List<int> lastNotificationIds = [];


  int cartCount = 0;

  void cartCountUpdate(int cart) {
    cartCount = cart;
    notifyListeners();
  }

  void updateUsername(MqttEvent? event) {
    username = event;
    notifyListeners();
  }

  void updateTemp(MqttEvent? event) async {
    temp = event;
    bool isHomeTempAlertOn = await getHomeTempAlertStatus();
    if (isHomeTempAlertOn) {
      List<String> range = await getHomeTempAlertRange();
      if (double.parse(range.first.toString()) <=
              int.parse(event?.temperature ?? "0") &&
          int.parse(event?.temperature ?? "0") <=
              double.parse(range.last.toString())) {
        print("in range");
      } else if(event?.temperature != null && event?.isNotified != 1) {
        DBProvider.db.updateEventNotifier(event?.id??0);
        NotificationManger().displayNotification(
            homeTempAlertNotificationId,
            "Home Temperature alert",
            "Guardian home temperature is ${event?.temperature}");
      }
    }
    notifyListeners();
  }

  void updateEss(MqttEvent? event) {
    ess = event;
    notifyListeners();
  }

  void updateMqtt(MqttEvent? event) {
    mqtt = event;
    notifyListeners();
  }

  void updateEthernet(MqttEvent? event) {
    int offlineDuration = MqttUtils().calculateTimeDifferenceBetweenInMinutes(
        event?.dateCreated, DateTime.now());
    if (event?.event == "mqtt" && event?.status == "offline") {
      event?.status = "disconnect";
      internetStatus();
    } else {
      if (offlineDuration >= 15) {
        event?.status = "disconnect";
        internetStatus();
      } else {
        event?.status = "connect";
      }
    }
    ethernet = event;
    notifyListeners();
  }

  void updatePir(MqttEvent? event) async {
    int minutesDiff = MqttUtils().calculateTimeDifferenceBetweenInMinutes(
        DateTime.now(), event?.dateCreated);
    if(minutesDiff >= 15){
      event?.status = "0";
    }else{
      event?.status = "1";
    }
    pir = event;
    notifyListeners();
    if (event?.event == "iamlife") {
      Timer(Duration(minutes: 16), ()async {
        event = await DBProvider.db.getLastPirActive();
        int hoursAlertTime = MqttUtils().calculateTimeDifferenceBetweenInMinutes(
            DateTime.now(), event?.dateCreated);
        if (hoursAlertTime >= 15) {
          event?.status = "0";
          pir = event;
          notifyListeners();
        }
      });

      bool isActivityAlertOn = await getPendantRangeAlertStatus();
      if (isActivityAlertOn == true) {
       // timerPirOutRange = Timer.periodic(Duration(seconds: 15), (timer) async {
          event = await DBProvider.db.getLastPirActive();
          int hoursAlertTime = MqttUtils().calculateTimeDifferenceBetweenInHour(
              DateTime.now(), event?.dateCreated);
          int activityAlertTime = await getPendantRangeAlertTime();
          if (hoursAlertTime >= activityAlertTime && event?.isNotified != 1) {
            DBProvider.db.updateEventNotifier(event?.id??0);
            NotificationManger().displayNotification(
                pendantRangeAlertNotificationId,
                "Pendant Alert",
                "Pendant out of range detected.");
          }
       // });
      } else {
        timerPirOutRange?.cancel();
      }
    }
    notifyListeners();
  }

  void updateBattery(MqttEvent? event) async {
    battery = event;
    bool isLowBatteryAlert = await getLowBatteryAlertStatus();
    if (isLowBatteryAlert == true) {
      int batt = int.tryParse(event?.batt ?? "100") ?? 100;
      if (batt <= 20 && event?.isNotified != 1) {
        DBProvider.db.updateEventNotifier(event?.id??0);
        NotificationManger().displayNotification(lowBatteryAlertNotificationId,
            "Battery Alert", "Low Battery Alert detected.");
      }
    }
    notifyListeners();
  }

  void updatePower(MqttEvent? event) {
    int offlineDuration = MqttUtils().calculateTimeDifferenceBetweenInMinutes(
        event?.dateCreated, DateTime.now());
    // if (offlineDuration >= 15) {
    //   event?.status = "released";
    // } else {
    //   event?.status = "pressed";
    // }
    if(event?.event == "button" && event?.name == "power") {
      power = event;
      powerStatus();
      notifyListeners();
    }
  }

  void updateHomeAway(MqttEvent? event) async {
    bool isUserAwayOn = await getUserAwayAlertStatus();
    if (isUserAwayOn == true) {
      //timerUserAway = Timer.periodic(Duration(seconds: 15), (timer) async {
        MqttEvent? mqttHomeAway = await Repository().getMqttHomeAway();
        if(mqttHomeAway?.status == "away" ) {
          int minutesAlertTime = MqttUtils()
              .calculateTimeDifferenceBetweenInHour(
              DateTime.now(), mqttHomeAway?.dateCreated);
          int activityAlertTime = await getUserAwayAlertTime();
          if (minutesAlertTime >= activityAlertTime && mqttHomeAway?.isNotified != 1) {
            await DBProvider.db.updateEventNotifier(mqttHomeAway?.id??0);
            NotificationManger().displayNotification(
                userAwayAlertNotificationId,
                "User Away Alert", "alert exceeded time");
          }
        }
     // });
    } else {
      timerUserAway?.cancel();
    }
    MqttEvent? mqttHomeAway = await Repository().getMqttHomeAway();
    homeAway = mqttHomeAway;
    notifyListeners();
  }

  void updateFireware(MqttEvent? event) {
    fireware = event;
    firewareUpdate();
    notifyListeners();
  }

  void updatePirDuration(String data) async {
    activityTimeCheck();
    //timerActivity = Timer.periodic(Duration(seconds: 15), (timer) async {
     // activityTimeCheck(false);
   // });
  }

  activityTimeCheck() async {
    MqttEvent? lastPir = await DBProvider.db.getLastPirActive();
    if (lastPir != null) {
      String? ago = MqttUtils()
          .calculateTimeDifferenceAgoNew(DateTime.now(), lastPir.dateCreated);
      bool isActivityAlertOn = await getActivityAlertStatus();
      if (isActivityAlertOn == true) {
        int minutesAlertTime = MqttUtils().calculateTimeDifferenceBetweenInHour(
            DateTime.now(), lastPir.dateCreated);
        int activityAlertTime = await getActivityAlertTime();
        if (minutesAlertTime >= activityAlertTime) {
          if (lastPir.isNotified != 1) {
            DBProvider.db.updateEventNotifier(lastPir.id??0);
            NotificationManger().displayNotification(
                activityAlertNotificationId,
                "Activtiy Alert",
                "alert exceeded time");
          }
          activityTimeExcceded = true;
        } else {
          activityTimeExcceded = false;
        }
      } else {
        activityTimeExcceded = false;
      }
      lastPirInActiveDuration = ago??"";
      notifyListeners();
    }
  }

  alarmActivityManage(MqttEvent? event) async {
    bool isAlarmCallOn = await getAlarmCallAlertStatus();
    if (isAlarmCallOn == true) {
      NotificationManger().displayNotification(alarmCallAlertNotificationId,
          "Alarm Alert", "Alarm activity detected ${event?.status ?? ""}");
    }
  }

  nightTimeExceedManage() async {
    bool isNightTimeExcced = await getNightTimeAlertExceedAlertStatus();
    if (isNightTimeExcced == true) {
      String bedTime = await getBedTime();
      DateTime end = MqttUtils()
          .durationToDate(Duration(microseconds: int.tryParse(bedTime) ?? 0));
      MqttEvent? lastevent = await DBProvider.db.getEventLat();
      print("end time ${end.toString()}");
      int nightTimeExceedMinutes = MqttUtils()
          .calculateTimeDifferenceBetweenInMinutes(lastevent?.dateCreated, end);
      if (nightTimeExceedMinutes >= 30 && lastevent?.isNotified != 1) {
        DBProvider.db.updateEventNotifier(lastevent?.id??0);
        NotificationManger().displayNotification(nightTimeAlertNotificationId,
            "Night Time Activity", "Sleep time exceed detected.");
      }
    } else {
      timerNightExceed?.cancel();
    }
  }

  wakeTimeExceedManage() async {
    bool isUpTimeExcced = await getWakeTimeAlertExceedAlertStatus();
    if (isUpTimeExcced == true) {
      //timerActivity = Timer.periodic(Duration(seconds: 30), (timer) async {
        String bedTime = await getWakeUpTime();
        DateTime start = MqttUtils()
            .durationToDate(Duration(microseconds: int.tryParse(bedTime) ?? 0));
        print("end time ${start.toString()}");
        int wakeTimeAlert = MqttUtils()
            .calculateTimeDifferenceBetweenInMinutes(DateTime.now(), start);
        if (wakeTimeAlert >= 30) {
          int todaysRecord = await DBProvider.db.getEventTodaysEventCount();
          if (todaysRecord == 0 ) {
            //TODO
            NotificationManger().displayNotification(
                wakeTimeAlertNotificationId,
                "Wake Up Time Activity",
                "wake time exceed detected.");
          }
        }
      //});
    } else {
      timerNightExceed?.cancel();
    }
  }

  lackOfMoment() async {
    bool isLackMomentOn = await getLackOfMomentAlertStatus();
    if (isLackMomentOn == true) {
     // timerLackOfMoment = Timer.periodic(Duration(minutes: 3), (timer) async {
            MqttEvent? event = await DBProvider.db.getEventLat();
            int lastEventDuration = MqttUtils()
                .calculateTimeDifferenceBetweenInHour(DateTime.now(), event?.dateCreated);
            int lackOfMomentTime = await getLackOfMomentTime();
            if(lastEventDuration >= lackOfMomentTime && event?.isNotified != 1) {
              DBProvider.db.updateEventNotifier(event?.id??0);
              NotificationManger().displayNotification(
                  lackOfMomentAlertNotificationId,
                  "Lack of Moment Activity",
                  "Not received any moment.");
            }

      //    });
    }else{
      timerLackOfMoment?.cancel();
    }
  }

  gaurdianNetwork() async {
    bool network = await getGaurdianNetworkAlertStatus();
    if (network == true) {
     // timerGuardianNetwork = Timer.periodic(Duration(minutes: 3), (timer) async {
        MqttEvent? event = await DBProvider.db.getEvent("mqtt");
        int lastEventDuration = MqttUtils()
            .calculateTimeDifferenceBetweenInMinutes(DateTime.now(), event?.dateCreated);
        if(event?.status == "offline") {
          if (lastEventDuration >= 5 && event?.isNotified != 1) {
            DBProvider.db.updateEventNotifier(event?.id??0);
            NotificationManger().displayNotification(
                gaurdianAlertNotificationId,
                "Guardian Network Activity",
                "network disconnected");
          }
        }
   //   });
    }else{
      timerGuardianNetwork?.cancel();
    }
  }

  powerStatus() async {
    bool powerOn = await getPowerStatus();
    if (powerOn == true) {
    //  timerPower = Timer.periodic(Duration(minutes: 3), (timer) async {
        MqttEvent? event = await DBProvider.db.getEvent("button");
        if(event?.name == "power") {
          int lastEventDuration = MqttUtils()
              .calculateTimeDifferenceBetweenInMinutes(
              DateTime.now(), event?.dateCreated);
          if (event?.status == "released") {
            if (lastEventDuration >= 10 && event?.isNotified != 1) {
              DBProvider.db.updateEventNotifier(event?.id??0);
              NotificationManger().displayNotification(
                  powerAlertNotificationId,
                  "Power Status Activity",
                  "Power disconnected");
            }
          }
        }
   //   });
    }else{
      timerPower?.cancel();
    }
  }

  internetStatus() async {
    bool powerOn = await getInternetStatus();
    if (powerOn == true) {
     // timerInternetLost = Timer.periodic(Duration(minutes: 3), (timer) async {
      MqttEvent? event = await DBProvider.db.getEvent("ethernet");
      MqttEvent? lastEvent = await DBProvider.db.getEventLat();
      if(event?.status == "disconnect" && event?.isNotified != 1) {
        int lastEventDuration = MqttUtils()
            .calculateTimeDifferenceBetweenInMinutes(
            DateTime.now(), lastEvent?.dateCreated);
          if (lastEventDuration >= 15 && event?.isNotified != 1) {
            DBProvider.db.updateEventNotifier(event?.id??0);
            NotificationManger().displayNotification(
                internetAlertNotificationId,
                "Internet Status Activity",
                "Internet disconnected.");
          }
      }
    //  });
    }else{
      timerInternetLost?.cancel();
    }
  }

  firewareUpdate() async {
    bool powerOn = await getFirewareUpdateStatus();
    if (powerOn == true) {
     // timerFirewareUpdate = Timer.periodic(Duration(minutes: 3), (timer) async {
        MqttEvent? event = await DBProvider.db.getEvent("firmware");
        if(event?.status == "update" && event?.isNotified != 1) {
          DBProvider.db.updateEventNotifier(event?.id??0);
          NotificationManger().displayNotification(
              firewareUpdateAlertNotificationId,
              "System update Activity",
              "Update available");
        }
     // });
    }else{
      timerFirewareUpdate?.cancel();
    }
  }

  void ruokCheck() async{
    bool isActiveNotification = await getRuOkAlertStatus();
    List<MqttEvent>? events = await DBProvider.db.getAllRuokEvents();
    List<MqttEvent>? noreponse = events?.where((element) => element.status != "making").toList();
    if(events?.length == 0){
     ruokStatus = RuokStatus.noset;
    }else if((events?.length??0) >= 1 && events?.first.status == "making"){
      List<MqttEvent>? makeCount =  events?.where((element) => element.status == "making").toList();
      print("make count ${makeCount?.length}");
      switch(makeCount?.length) {
        case 1: {
          ruokStatus = RuokStatus.announcement1;
        }
        break;
        case 2: {
          ruokStatus = RuokStatus.announcement2;
        }
        break;
        case 3: {
          ruokStatus = RuokStatus.announcement3;
        }
        break;
        case 4: {
          ruokStatus = RuokStatus.announcement4;
        }
        break;
        case 5: {
          ruokStatus = RuokStatus.announcement5;
          if(isActiveNotification == true){
            int minutesAlertTime = MqttUtils()
                .calculateTimeDifferenceBetweenInHour(
                DateTime.now(), events?.first?.dateCreated);
            int activityAlertTime = await getRuOkAlertTime();
            if (minutesAlertTime >= activityAlertTime && events?.first?.isNotified != 1) {
              await DBProvider.db.updateEventNotifier(events?.first?.id??0);
              NotificationManger().displayNotification(
                  ruOKAlertNotificationId,
                  "Are you ok reminder", "alert exceeded time");
            }
          }
        }
        break;
        default: {
          ruokStatus = RuokStatus.announcement1;
        }
        break;
      }
    }else if(events?.first.status == "responded"){
      ruokStatus = RuokStatus.acknowledged;
    }else if(events?.first.status == "noresponse"){
      ruokStatus = RuokStatus.noresponse;
    }
    if(events?.length != 0) {
      ruok = events?.first;
    }
    if(isActiveNotification == false){
      NotificationManger().cancelNotification(
          ruOKAlertNotificationId);
    }
    print("ruok Status :$ruokStatus");
    notifyListeners();
  }

  void medicationEvent() async{
    bool isActiveNotification = await getMediAlertStatus();
    List<MqttEvent>? events = await DBProvider.db.getAllMedicationEvents();
    List<MqttEvent>? noreponse = events?.where((element) => element.status != "making").toList();
    if(events?.length == 0){
      medicationStatus = RuokStatus.noset;
    }else if((events?.length??0) >= 1 && events?.first.status == "making"){
      List<MqttEvent>? makeCount =  events?.where((element) => element.status == "making").toList();
      print("make count ${makeCount?.length}");
      switch(makeCount?.length) {
        case 1: {
          medicationStatus = RuokStatus.announcement1;
        }
        break;
        case 2: {
          medicationStatus = RuokStatus.announcement2;
        }
        break;
        case 3: {
          medicationStatus = RuokStatus.announcement3;
        }
        break;
        case 4: {
          medicationStatus = RuokStatus.announcement4;
        }
        break;
        case 5: {
          medicationStatus = RuokStatus.announcement5;
          if(isActiveNotification == true){
            int minutesAlertTime = MqttUtils()
                .calculateTimeDifferenceBetweenInHour(
                DateTime.now(), events?.first?.dateCreated);
            int activityAlertTime = await getMediAlertTime();
            if (minutesAlertTime >= activityAlertTime && events?.first?.isNotified != 1) {
              await DBProvider.db.updateEventNotifier(events?.first?.id??0);
              NotificationManger().displayNotification(
                  medicationAlertNotificationId,
                  "Medication Reminder", "alert exceeded time");
            }
          }
        }
        break;
        default: {
          medicationStatus = RuokStatus.announcement1;
        }
        break;
      }
    }else if(events?.first.status == "responded"){
      medicationStatus = RuokStatus.acknowledged;
    }else if(events?.first.status == "noresponse"){
      medicationStatus = RuokStatus.noresponse;
    }
    if(events?.length != 0) {
      medication = events?.first;
    }
    if(isActiveNotification == false){
      NotificationManger().cancelNotification(
          medicationAlertNotificationId);
    }
    print("ruok Status :$ruokStatus");
    notifyListeners();
  }
}
