import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/components/notification/notification_manager.dart';
import 'package:guardian/screens/drawer/Drawer.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../components/app_bar_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class ActivityAlertWidget extends StatefulWidget {
  ActivityAlertWidget({Key? key}) : super(key: key);

  @override
  _ActivityAlertWidgetState createState() => _ActivityAlertWidgetState();
}

class _ActivityAlertWidgetState extends State<ActivityAlertWidget> {
  bool _loadingButton = false;
  double sliderValue = 0.0;
  bool isUserAway = false;
  bool isHomeTempAlertOn = false;
  bool isIAmCheckOn = false;
  bool isActivityAlertOn = false;
  bool isWakeUpAlertOn = false;
  bool isBedAlertOn = false;
  bool isAlarmCallAlertOn = false;
  bool isPendantOutRangeAlertOn = false;
  double pendantRangeAlertValue = 8.0;
  bool pendantAlertShow = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Duration? wakeUpTime = Duration(hours: 0, minutes: 0);
  Duration? bedTime = Duration(hours: 0, minutes: 0);
  double activityAlertValue = 8.0;
  bool activityAlertShow = false;
  bool homeAlertShow = false;
  bool userAwayAlertShow = false;
  double userAwayAlertValue = 8.0;
  SfRangeValues temperatureValues = SfRangeValues(15.0, 26.0);
  bool isLowBatteryAlertOn = false;
  bool isNightTimeAlertOn = false;
  bool isNotGotUpAlertOn = false;
  bool isLackOfMomentView = false;
  bool isLackOfMomentOn = false;
  double lackOfMomentTime = 6.0;
  bool isGuardianNetworkStatus = false;
  bool isPowerStatus = false;
  bool isInternetStatus = false;
  bool isFirewareUpdateStatus = false;
  String username = "";
  bool ruOKAlertShow = false;
  bool ruOKAlert = false;
  double ruOkAlertValue = 8.0;
  bool mediAlertShow = false;
  bool mediAlert = false;
  double mediAlertValue = 8.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  init() async {
    username = (await MqttNotifier().username?.name)??"";
    isAlarmCallAlertOn = await getAlarmCallAlertStatus();

    isUserAway = await getUserAwayAlertStatus();
    userAwayAlertValue = (await getUserAwayAlertTime()).toDouble();

    isHomeTempAlertOn = await getHomeTempAlertStatus();
    List<String> tempValue = await getHomeTempAlertRange();
    temperatureValues = SfRangeValues(
        double.parse(tempValue.first), double.parse(tempValue.last));

    isActivityAlertOn = await getActivityAlertStatus();
    activityAlertValue = (await getActivityAlertTime()).toDouble();

    isPendantOutRangeAlertOn = await getPendantRangeAlertStatus();
    pendantRangeAlertValue = (await getPendantRangeAlertTime()).toDouble();

    isLowBatteryAlertOn = await getLowBatteryAlertStatus();

    //
    isNightTimeAlertOn = await getNightTimeAlertExceedAlertStatus();
    isNotGotUpAlertOn = await getWakeTimeAlertExceedAlertStatus();

    //lack of moment
    isLackOfMomentOn = await getLowBatteryAlertStatus();
    lackOfMomentTime = (await getLackOfMomentTime()).toDouble();

    isGuardianNetworkStatus = await getGaurdianNetworkAlertStatus();

    isPowerStatus = await getPowerStatus();
    isInternetStatus = await getInternetStatus();
    isFirewareUpdateStatus = await getFirewareUpdateStatus();

    //wake up
    isWakeUpAlertOn = await getWakeUpStatus();
    String wakeupString = await getWakeUpTime();
    print("wake up time $wakeupString");
    setState(() {
      wakeUpTime = Duration(microseconds: int.tryParse(wakeupString) ?? 0);
    });
    print(
        "wake up time Duration --   ${wakeUpTime?.inHours}  ${wakeUpTime?.inMinutes}");

    isBedAlertOn = await getBedStatus();
    String bedString = await getBedTime();
    print("bed time $bedString");
    setState(() {
      bedTime = Duration(microseconds: int.tryParse(bedString) ?? 0);
    });
    print("bed Duration --   ${bedTime?.inHours}  ${bedTime?.inMinutes}");

    ruOKAlert = await getRuOkAlertStatus();
    ruOkAlertValue = (await getRuOkAlertTime()).toDouble();

    mediAlert = await getMediAlertStatus();
    mediAlertValue = (await getMediAlertTime()).toDouble();

    setState(() {});
  }

  Widget itemAlertView(String title,bool isActive,Function ontap,Function onChange){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, 8, 2, 0),
      child: InkWell(
        onTap:()=>ontap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isActive
                ? Color(0xFFD6D679)
                : Color(0xFFC04848),
            borderRadius:
            BorderRadius.circular(50),
          ),
          child: Padding(
            padding:
            EdgeInsetsDirectional.fromSTEB(
                8, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Switch(
                  value: isActive,
                  onChanged: (newValue) async {
                    onChange(newValue);
                  },
                  inactiveThumbColor: Colors.grey,
                  activeColor: Colors.white,
                  activeTrackColor:
                  Color(0xFF682929),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: DrawerScreen(),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Group_933.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppBarComponentWidget(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: UserInfoAwayView(),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xffD7EEEE),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "Set Alerts to check on the alarm to make sure they're OK & to make sure their personal alarm is working correctly",
                        style: TextStyle(
                            color: Color(0xff0766A1),
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Consumer<MqttNotifier>(
                                      builder: (context, mqtt, child) {
                                    return Text(
                                      'Set ${mqtt.username?.name?.split(" ").first}\'s Normal\nBedtime Routine',
                                      style: TextStyle(
                                        color: Color(0xff2867A3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  }),

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        _normalGetUpTimeView();
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isWakeUpAlertOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Wake Up Check',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isWakeUpAlertOn,
                                                onChanged: (newValue) async {
                                                  await saveWakeUpStatus(
                                                      newValue);
                                                  setState(() {
                                                    isWakeUpAlertOn = newValue;
                                                  });
                                                  if (newValue == true) {
                                                    NotificationManger()
                                                        .scheduleNotificationEveryDay(
                                                        wakeNotificationId,
                                                        MqttUtils()
                                                            .durationToTime(
                                                            wakeUpTime!),
                                                        "Wake Up Reminder",
                                                        "Wake up");
                                                  } else {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        wakeNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        _normalBedTimeView();
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isBedAlertOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Bed Time Check',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isBedAlertOn,
                                                onChanged: (newValue) async {
                                                  await saveBedStatus(newValue);
                                                  setState(() {
                                                    isBedAlertOn = newValue;
                                                  });
                                                  if (newValue == true) {
                                                    NotificationManger()
                                                        .scheduleNotificationEveryDay(
                                                        bedTimeNotificationId,
                                                        MqttUtils()
                                                            .durationToTime(
                                                            bedTime!),
                                                        "Bed Time Reminder",
                                                        "Bed Time");
                                                  } else {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        bedTimeNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24,),
                                  Text(
                                    'Emergency Alerts',
                                    style: TextStyle(
                                      color: Color(0xff2867A3),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isLowBatteryAlertOn =
                                          !isLowBatteryAlertOn;
                                        });
                                        saveLowBatteryAlertStatus(
                                            isLowBatteryAlertOn);
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isLowBatteryAlertOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Low Pendant Battery',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isLowBatteryAlertOn,
                                                onChanged: (newValue) async {
                                                  saveLowBatteryAlertStatus(
                                                      newValue);
                                                  setState(() {
                                                    isLowBatteryAlertOn =
                                                    !isLowBatteryAlertOn;
                                                  });
                                                  if (newValue == false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        lowBatteryAlertNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          pendantAlertShow = !pendantAlertShow;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isPendantOutRangeAlertOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Pendant Out Of Range',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isPendantOutRangeAlertOn,
                                                onChanged: (newValue) async {
                                                  saveAlarmCallAlertStatus(
                                                      newValue);
                                                  setState(() {
                                                    isPendantOutRangeAlertOn =
                                                    !isPendantOutRangeAlertOn;
                                                  });
                                                  if (newValue == false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        pendantRangeAlertNotificationId);
                                                  }
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .updatePir(MqttEvent());
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          homeAlertShow = !homeAlertShow;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isHomeTempAlertOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Home Temperature',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isHomeTempAlertOn,
                                                onChanged: (newValue) async {
                                                  await saveHomeTempAlertStatus(
                                                      newValue);
                                                  if (newValue == true) {
                                                    MqttEvent? mqttTemp =
                                                    await Repository()
                                                        .getMqttTemp(
                                                        context);
                                                    Provider.of<MqttNotifier>(
                                                        context,
                                                        listen: false)
                                                        .updateTemp(mqttTemp);
                                                  }
                                                  setState(() {
                                                    isHomeTempAlertOn =
                                                        newValue;
                                                  });
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Consumer<MqttNotifier>(
                                                builder: (context, mqtt, child) {
                                                  return  Text(
                                                   // '${mqtt.username?.name?.split(" ").first} I\'m Ok Check-In',
                                                    'I\'m Ok Check-In',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  );
                                                }),
                                            Switch(
                                              value: isIAmCheckOn,
                                              onChanged: (newValue) => setState(
                                                      () =>
                                                  isIAmCheckOn = newValue),
                                              inactiveThumbColor: Colors.grey,
                                              activeColor: Colors.white,
                                              activeTrackColor:
                                              Color(0xFF682929),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isLackOfMomentView =
                                          !isLackOfMomentView;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isLackOfMomentOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Lack Of Movement Indicator',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isLackOfMomentOn,
                                                onChanged: (newValue) async {
                                                  saveLackOfMomentStatus(
                                                      newValue);
                                                  setState(() {
                                                    isLackOfMomentOn =
                                                    !isLackOfMomentOn;
                                                  });
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .lackOfMoment();
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isNightTimeAlertOn =
                                          !isNightTimeAlertOn;
                                        });
                                        saveNightTimeAlertExceedAlertStatus(
                                            isLowBatteryAlertOn);
                                        if (isNightTimeAlertOn == true) {
                                          Provider.of<MqttNotifier>(context,
                                              listen: false)
                                              .nightTimeExceedManage();
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isNightTimeAlertOn
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Unsual Night Time Activity',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isNightTimeAlertOn,
                                                onChanged: (newValue) async {
                                                  saveNightTimeAlertExceedAlertStatus(
                                                      newValue);
                                                  setState(() {
                                                    isNightTimeAlertOn =
                                                    !isNightTimeAlertOn;
                                                  });
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .nightTimeExceedManage();
                                                  if (newValue == false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        nightTimeAlertNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          userAwayAlertShow =
                                          !userAwayAlertShow;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isUserAway
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Consumer<MqttNotifier>(
                                                  builder: (context, mqtt, child) {
                                                    return Text(
                                                      //'${mqtt.username?.name?.split(" ").first} User Away For Too Long',
                                                      'User Away For Too Long',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    );
                                                  }),
                                              Switch(
                                                value: isUserAway,
                                                onChanged: (newValue) async {
                                                  await saveUserAwayAlertStatus(
                                                      newValue);
                                                  if (newValue == true) {
                                                    Provider.of<MqttNotifier>(
                                                        context,
                                                        listen: false)
                                                        .updateHomeAway(
                                                        MqttEvent());
                                                  } else {
                                                    Provider.of<MqttNotifier>(
                                                        context,
                                                        listen: false)
                                                        .updateHomeAway(
                                                        MqttEvent());
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        userAwayAlertNotificationId);
                                                  }
                                                  setState(() {
                                                    isUserAway = newValue;
                                                  });
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //are you ok
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       0, 8, 2, 0),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         ruOKAlertShow =
                                  //         !ruOKAlertShow;
                                  //       });
                                  //     },
                                  //     child: Container(
                                  //       height: 40,
                                  //       decoration: BoxDecoration(
                                  //         color: ruOKAlert
                                  //             ? Color(0xFFD6D679)
                                  //             : Color(0xFFC04848),
                                  //         borderRadius:
                                  //         BorderRadius.circular(50),
                                  //       ),
                                  //       child: Padding(
                                  //         padding:
                                  //         EdgeInsetsDirectional.fromSTEB(
                                  //             8, 0, 0, 0),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Consumer<MqttNotifier>(
                                  //                 builder: (context, mqtt, child) {
                                  //                   return Text(
                                  //                     'Are You Ok',
                                  //                     style: TextStyle(
                                  //                       color: Colors.white,
                                  //                       fontSize: 20,
                                  //                     ),
                                  //                   );
                                  //                 }),
                                  //             Switch(
                                  //               value: ruOKAlert,
                                  //               onChanged: (newValue) async {
                                  //                 await saveRuOkAlertStatus(
                                  //                     newValue);
                                  //                 if (newValue == true) {
                                  //                   Provider.of<MqttNotifier>(
                                  //                       context,
                                  //                       listen: false)
                                  //                       .ruokCheck();
                                  //                 } else {
                                  //                   Provider.of<MqttNotifier>(
                                  //                       context,
                                  //                       listen: false)
                                  //                       .ruokCheck();
                                  //                   NotificationManger()
                                  //                       .cancelNotification(
                                  //                       ruOKAlertNotificationId);
                                  //                 }
                                  //                 setState(() {
                                  //                   ruOKAlert = newValue;
                                  //                 });
                                  //               },
                                  //               inactiveThumbColor: Colors.grey,
                                  //               activeColor: Colors.white,
                                  //               activeTrackColor:
                                  //               Color(0xFF682929),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  //medication
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          mediAlertShow =
                                          !mediAlertShow;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: mediAlert
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Consumer<MqttNotifier>(
                                                  builder: (context, mqtt, child) {
                                                    return Text(
                                                      'Medication Reminder',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    );
                                                  }),
                                              Switch(
                                                value: mediAlert,
                                                onChanged: (newValue) async {
                                                  await saveMediAlertStatus(
                                                      newValue);
                                                  if (newValue == true) {
                                                    Provider.of<MqttNotifier>(
                                                        context,
                                                        listen: false)
                                                        .medicationEvent();
                                                  } else {
                                                    Provider.of<MqttNotifier>(
                                                        context,
                                                        listen: false)
                                                        .medicationEvent();
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        medicationAlertNotificationId);
                                                  }
                                                  setState(() {
                                                    mediAlert = newValue;
                                                  });
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //----

                                  SizedBox(height: 24,),
                                  Text(
                                    'System Alerts',
                                    style: TextStyle(
                                      color: Color(0xff2867A3),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isPowerStatus = !isPowerStatus;
                                        });
                                        savePowerStatus(isPowerStatus);
                                        Provider.of<MqttNotifier>(context,
                                            listen: false)
                                            .powerStatus();
                                        if (isPowerStatus == false) {
                                          NotificationManger()
                                              .cancelNotification(
                                              powerAlertNotificationId);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isPowerStatus
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Power Down',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isPowerStatus,
                                                onChanged: (newValue) async {
                                                  savePowerStatus(newValue);
                                                  setState(() {
                                                    isPowerStatus =
                                                    !isPowerStatus;
                                                  });
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .powerStatus();
                                                  if (isPowerStatus == false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        powerAlertNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isInternetStatus = !isInternetStatus;
                                        });
                                        saveInternetStatus(isInternetStatus);
                                        Provider.of<MqttNotifier>(context,
                                            listen: false)
                                            .internetStatus();
                                        if (isInternetStatus == false) {
                                          NotificationManger()
                                              .cancelNotification(
                                              internetAlertNotificationId);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isInternetStatus
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Internet Down',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isInternetStatus,
                                                onChanged: (newValue) async {
                                                  saveInternetStatus(newValue);
                                                  setState(() {
                                                    isInternetStatus =
                                                    !isInternetStatus;
                                                  });
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .internetStatus();
                                                  if (isInternetStatus ==
                                                      false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        internetAlertNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isGuardianNetworkStatus =
                                          !isGuardianNetworkStatus;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isGuardianNetworkStatus
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Guardian Network Down',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isGuardianNetworkStatus,
                                                onChanged: (newValue) async {
                                                  saveGaurdianNetworkAlertStatus(
                                                      newValue);
                                                  setState(() {
                                                    isGuardianNetworkStatus =
                                                    !isGuardianNetworkStatus;
                                                  });
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .gaurdianNetwork();
                                                  if (isGuardianNetworkStatus ==
                                                      false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        gaurdianAlertNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 2, 0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isFirewareUpdateStatus =
                                          !isFirewareUpdateStatus;
                                        });
                                        saveFirewareUpdateStatus(
                                            isFirewareUpdateStatus);
                                        Provider.of<MqttNotifier>(context,
                                            listen: false)
                                            .firewareUpdate();
                                        if (isFirewareUpdateStatus == false) {
                                          NotificationManger().cancelNotification(
                                              firewareUpdateAlertNotificationId);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isFirewareUpdateStatus
                                              ? Color(0xFFD6D679)
                                              : Color(0xFFC04848),
                                          borderRadius:
                                          BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'System Updates',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Switch(
                                                value: isFirewareUpdateStatus,
                                                onChanged: (newValue) async {
                                                  saveFirewareUpdateStatus(
                                                      newValue);
                                                  setState(() {
                                                    isFirewareUpdateStatus =
                                                    !isFirewareUpdateStatus;
                                                  });
                                                  Provider.of<MqttNotifier>(
                                                      context,
                                                      listen: false)
                                                      .firewareUpdate();
                                                  if (isFirewareUpdateStatus ==
                                                      false) {
                                                    NotificationManger()
                                                        .cancelNotification(
                                                        firewareUpdateAlertNotificationId);
                                                  }
                                                },
                                                inactiveThumbColor: Colors.grey,
                                                activeColor: Colors.white,
                                                activeTrackColor:
                                                Color(0xFF682929),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 24,),
                                  //new

                                 


                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       0, 8, 2, 0),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //      setState(() {
                                  //        activityAlertShow = !activityAlertShow;
                                  //      });
                                  //     },
                                  //     child: Container(
                                  //       height: 40,
                                  //       decoration: BoxDecoration(
                                  //         color: isActivityAlertOn
                                  //             ? Color(0xFFD6D679)
                                  //             : Color(0xFFC04848),
                                  //         borderRadius:
                                  //             BorderRadius.circular(50),
                                  //       ),
                                  //       child: Padding(
                                  //         padding:
                                  //             EdgeInsetsDirectional.fromSTEB(
                                  //                 8, 0, 0, 0),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Text(
                                  //               'Activity Alert',
                                  //               style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 20,
                                  //               ),
                                  //             ),
                                  //             Switch(
                                  //               value: isActivityAlertOn,
                                  //               onChanged: (newValue)async{
                                  //                 await saveActivityAlertStatus(newValue);
                                  //                 Provider.of<MqttNotifier>(context, listen: false).updatePirDuration("");
                                  //                 setState(() {
                                  //                   isActivityAlertOn = newValue;
                                  //                 });
                                  //               },
                                  //               inactiveThumbColor: Colors.grey,
                                  //               activeColor: Colors.white,
                                  //               activeTrackColor:
                                  //                   Color(0xFF682929),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       0, 8, 2, 0),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         isAlarmCallAlertOn =
                                  //         !isAlarmCallAlertOn;
                                  //       });
                                  //       saveAlarmCallAlertStatus(
                                  //           isAlarmCallAlertOn);
                                  //     },
                                  //     child: Container(
                                  //       height: 40,
                                  //       decoration: BoxDecoration(
                                  //         color: isAlarmCallAlertOn
                                  //             ? Color(0xFFD6D679)
                                  //             : Color(0xFFC04848),
                                  //         borderRadius:
                                  //         BorderRadius.circular(50),
                                  //       ),
                                  //       child: Padding(
                                  //         padding:
                                  //         EdgeInsetsDirectional.fromSTEB(
                                  //             8, 0, 0, 0),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Text(
                                  //               'Alarm Call',
                                  //               style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 20,
                                  //               ),
                                  //             ),
                                  //             Switch(
                                  //               value: isAlarmCallAlertOn,
                                  //               onChanged: (newValue) async {
                                  //                 saveAlarmCallAlertStatus(
                                  //                     newValue);
                                  //                 setState(() {
                                  //                   isAlarmCallAlertOn =
                                  //                   !isAlarmCallAlertOn;
                                  //                 });
                                  //                 if (newValue == false) {
                                  //                   NotificationManger()
                                  //                       .cancelNotification(
                                  //                       alarmCallAlertNotificationId);
                                  //                 }
                                  //               },
                                  //               inactiveThumbColor: Colors.grey,
                                  //               activeColor: Colors.white,
                                  //               activeTrackColor:
                                  //               Color(0xFF682929),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsetsDirectional.fromSTEB(
                                  //       0, 8, 2, 0),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         isNotGotUpAlertOn =
                                  //         !isNotGotUpAlertOn;
                                  //       });
                                  //       saveWakeTimeAlertExceedAlertStatus(
                                  //           isNotGotUpAlertOn);
                                  //       Provider.of<MqttNotifier>(context,
                                  //           listen: false)
                                  //           .wakeTimeExceedManage();
                                  //     },
                                  //     child: Container(
                                  //       height: 40,
                                  //       decoration: BoxDecoration(
                                  //         color: isNotGotUpAlertOn
                                  //             ? Color(0xFFD6D679)
                                  //             : Color(0xFFC04848),
                                  //         borderRadius:
                                  //         BorderRadius.circular(50),
                                  //       ),
                                  //       child: Padding(
                                  //         padding:
                                  //         EdgeInsetsDirectional.fromSTEB(
                                  //             8, 0, 0, 0),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //           children: <Widget>[
                                  //             Text(
                                  //               'Not Got Up!',
                                  //               style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 20,
                                  //               ),
                                  //             ),
                                  //             Switch(
                                  //               value: isNotGotUpAlertOn,
                                  //               onChanged: (newValue) async {
                                  //                 saveWakeTimeAlertExceedAlertStatus(
                                  //                     newValue);
                                  //                 setState(() {
                                  //                   isNotGotUpAlertOn =
                                  //                   !isNotGotUpAlertOn;
                                  //                 });
                                  //                 Provider.of<MqttNotifier>(
                                  //                     context,
                                  //                     listen: false)
                                  //                     .wakeTimeExceedManage();
                                  //                 if (newValue == false) {
                                  //                   NotificationManger()
                                  //                       .cancelNotification(
                                  //                       wakeTimeAlertNotificationId);
                                  //                 }
                                  //               },
                                  //               inactiveThumbColor: Colors.grey,
                                  //               activeColor: Colors.white,
                                  //               activeTrackColor:
                                  //               Color(0xFF682929),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),



                                ],
                              ),
                            ),
                            SizedBox(
                              height: 150,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (mediAlertShow == true) _mediView(),
                if (ruOKAlertShow == true) _ruOkView(),
                if (userAwayAlertShow == true) _userAwayView(),
                if (activityAlertShow == true) _activityAlertView(),
                if (homeAlertShow == true) _homeAlertView(),
                if (pendantAlertShow == true) _pendantOutOfRangeView(),
                if (isLackOfMomentView == true) _lackOfMomentView(),
                // Align(
                //   alignment: AlignmentDirectional(0, 1.04),
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: Color(0x8F000000),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Every 3 hours',
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.normal,
                //               fontSize: 30,
                //             ),
                //           ),
                //           Slider(
                //             activeColor: Colors.white,
                //             inactiveColor: Color(0x32000000),
                //             min: 0,
                //             max: 12,
                //             value: sliderValue,
                //             onChanged: (newValue) {
                //               setState(() => sliderValue = newValue);
                //             },
                //           ),
                //           Padding(
                //             padding:
                //                 EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
                //             child: FFButtonWidget(
                //               onPressed: () {
                //                 print('Button pressed ...');
                //               },
                //               text: 'Save Alerts',
                //               options: FFButtonOptions(
                //                 width: 300,
                //                 height: 50,
                //                 color: FlutterFlowTheme.primaryColor,
                //                 textStyle: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 24,
                //                 ),
                //                 borderSide: BorderSide(
                //                   color: Colors.transparent,
                //                   width: 1,
                //                 ),
                //                 borderRadius: 50,
                //               ),
                //               loading: _loadingButton,
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _lackOfMomentView() {
    return InkWell(
      onTap: () {
        setState(() {
          isLackOfMomentView = !isLackOfMomentView;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lack of Moment Indicator',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Select after how long you\'d like an alert to say there has been no movement',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${lackOfMomentTime.toInt()} hour',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 24,
                    divisions: 30,
                    value: lackOfMomentTime.toDouble(),
                    onChanged: (newValue) async {
                      setState(() {
                        lackOfMomentTime = newValue;
                      });
                    },
                  ),
                  Text(
                    'App will alert you if there has been no movement for the selected amount of time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 8,),
                  FFButtonWidget(
                    onPressed: () async {
                      await saveLackOfMomentStatus(true);
                      await saveLackOfMomentTime(lackOfMomentTime.toInt());
                      Fluttertoast.showToast(
                          msg: "Lack of moment Alert set successfully");
                      Provider.of<MqttNotifier>(context, listen: false)
                          .lackOfMoment();
                      setState(() {
                        isLackOfMomentView = !isLackOfMomentView;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mediView() {
    return InkWell(
      onTap: () {
        setState(() {
          mediAlertShow = !mediAlertShow;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Medication Reminder Alert',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'this reminder remind you after if time is greater than you set and are you ok.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${mediAlertValue.toInt()} hour',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 24,
                    divisions: 30,
                    value: mediAlertValue.toDouble(),
                    onChanged: (newValue) async {
                      setState(() {
                        mediAlertValue = newValue;
                      });
                    },
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await saveMediAlertStatus(true);
                      await saveMediAlertTime(mediAlertValue.toInt());
                      Fluttertoast.showToast(
                          msg: "Medication Reminder Alert set successfully");
                      Provider.of<MqttNotifier>(context, listen: false)
                          .medicationEvent();
                      setState(() {
                        mediAlertShow = !mediAlertShow;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ruOkView() {
    return InkWell(
      onTap: () {
        setState(() {
          ruOKAlertShow = !ruOKAlertShow;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are You Ok Alert',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'this reminder remind you after if time is greater than you set and are you ok.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${ruOkAlertValue.toInt()} hour',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 24,
                    divisions: 30,
                    value: ruOkAlertValue.toDouble(),
                    onChanged: (newValue) async {
                      setState(() {
                        ruOkAlertValue = newValue;
                      });
                    },
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await saveRuOkAlertStatus(true);
                      await saveRuOkAlertTime(ruOkAlertValue.toInt());
                      Fluttertoast.showToast(
                          msg: "Are You Ok Alert set successfully");
                      Provider.of<MqttNotifier>(context, listen: false)
                          .updateHomeAway(MqttEvent());
                      setState(() {
                        ruOKAlertShow = !ruOKAlertShow;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userAwayView() {
    return InkWell(
      onTap: () {
        setState(() {
          userAwayAlertShow = !userAwayAlertShow;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'User Away Alert',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'this reminder remind you after if time is greater than you set and user away from home.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${userAwayAlertValue.toInt()} hour',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 24,
                    divisions: 30,
                    value: userAwayAlertValue.toDouble(),
                    onChanged: (newValue) async {
                      setState(() {
                        userAwayAlertValue = newValue;
                      });
                    },
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await saveUserAwayAlertStatus(true);
                      await saveUserAwayAlertTime(userAwayAlertValue.toInt());
                      Fluttertoast.showToast(
                          msg: "User Away Alert set successfully");
                      Provider.of<MqttNotifier>(context, listen: false)
                          .updateHomeAway(MqttEvent());
                      setState(() {
                        userAwayAlertShow = !userAwayAlertShow;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pendantOutOfRangeView() {
    return InkWell(
      onTap: () {
        setState(() {
          pendantAlertShow = !pendantAlertShow;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pendant Out of Range',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Select after how long you\'d like an alert to say the pendant is out of range i.e. away from home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${pendantRangeAlertValue.toInt()} hour',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 24,
                    divisions: 30,
                    value: pendantRangeAlertValue.toDouble(),
                    onChanged: (newValue) async {
                      setState(() {
                        pendantRangeAlertValue = newValue;
                      });
                    },
                  ),
                  Text(
                    'App will alert you if the pendant has been out of range for the selected time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 8,),
                  FFButtonWidget(
                    onPressed: () async {
                      await savePendantRangeAlertStatus(true);
                      await savePendantRangeAlertTime(
                          pendantRangeAlertValue.toInt());
                      Fluttertoast.showToast(
                          msg: "Pendant out of range Alert set successfully");
                      Provider.of<MqttNotifier>(context, listen: false)
                          .updatePir(MqttEvent());
                      setState(() {
                        pendantAlertShow = !pendantAlertShow;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeAlertView() {
    return InkWell(
      onTap: () {
        setState(() {
          homeAlertShow = !homeAlertShow;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Home Temperature Alert',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Select minimum and maximum temperature for \'s home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${double.parse(temperatureValues.start.toString()).toStringAsFixed(1)} °C - ${double.parse(temperatureValues.end.toString()).toStringAsFixed(1)} °C',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SfRangeSlider(
                    min: 0.0,
                    max: 40.0,
                    values: temperatureValues,
                    interval: 20,
                    showTicks: true,
                    showLabels: true,
                    minorTicksPerInterval: 1,
                    endThumbIcon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MqttRedColor
                      ),
                      child: Center(
                        child: FaIcon(
                        FontAwesomeIcons.hotjar,
                        color: Colors.white,
                          size: 14,
                    ),
                      ),),
                    startThumbIcon: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.snowflake,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),),
                    activeColor: MqttGreenColor,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        temperatureValues = values;
                      });
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'App will alert you if temperature not in range ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await saveHomeTempAlertStatus(true);
                      await saveHomeTempAlertRange([
                        "${temperatureValues.start}",
                        "${temperatureValues.end}"
                      ]);
                      Fluttertoast.showToast(
                          msg: "Home Temperature Alert set successfully");
                      MqttEvent? mqttTemp =
                          await Repository().getMqttTemp(context);
                      Provider.of<MqttNotifier>(context, listen: false)
                          .updateTemp(mqttTemp);
                      setState(() {
                        homeAlertShow = !homeAlertShow;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _activityAlertView() {
    return InkWell(
      onTap: () {
        setState(() {
          activityAlertShow = !activityAlertShow;
        });
      },
      child: Container(
        color: Colors.black45,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Activity Alert',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'this reminder remind you after if time is greater than you set.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAA08B),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${activityAlertValue.toInt()} min',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    value: activityAlertValue.toDouble(),
                    onChanged: (newValue) async {
                      setState(() {
                        activityAlertValue = newValue;
                      });
                    },
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      await saveActivityAlertStatus(true);
                      await saveActivityAlertTime(activityAlertValue.toInt());
                      Fluttertoast.showToast(
                          msg: "Activity Alert set successfully");
                      Provider.of<MqttNotifier>(context, listen: false)
                          .updatePirDuration("");
                      setState(() {
                        activityAlertShow = !activityAlertShow;
                      });
                      init();
                    },
                    text: 'SAVE',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 50,
                    ),
                    loading: _loadingButton,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _normalGetUpTimeView() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: double.infinity,
          alignment: Alignment.center,
          //color: Color(0xffC3C3C3),
          child: Column(
            children: [
              Text(
                'Wake up check',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Select what time the pendant alarm user normally gets',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAAA08B),
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: CupertinoTimerPicker(
                  initialTimerDuration:
                      wakeUpTime ?? Duration(hours: 0, minutes: 0),
                  //initialTimerDuration: Duration(hours: 6,minutes: 0),
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (data) {
                    setState(() {
                      wakeUpTime = data;
                    });
                    print(
                        "wake duration ${wakeUpTime.toString()} ${wakeUpTime?.inHours}");
                  },
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (wakeUpTime == null) {
                    Fluttertoast.showToast(msg: "Please select wakeup time");
                  } else {
                    await saveWakeUpTime("${wakeUpTime?.inMicroseconds}");
                    await saveWakeUpStatus(true);
                    NotificationManger().scheduleNotificationEveryDay(
                        wakeNotificationId,
                        MqttUtils().durationToTime(wakeUpTime!),
                        "Wake Up Reminder",
                        "Wake up");
                    Fluttertoast.showToast(
                        msg: "Wake up alert set Successfully");
                    Navigator.pop(context);
                    init();
                  }
                },
                text: 'SAVE',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 50,
                ),
                loading: _loadingButton,
              ),
            ],
          ),
        );
      },
    );
  }

  _normalBedTimeView() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'Bed time Check',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Select what time pendant alarm user normally goes to bed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFAAA08B),
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: CupertinoTimerPicker(
                  initialTimerDuration:
                      bedTime ?? Duration(hours: 0, minutes: 0),
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (data) {
                    setState(() {
                      bedTime = data;
                    });
                    print(
                        "wake duration ${bedTime.toString()} ${bedTime?.inHours}");
                  },
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (bedTime == null) {
                    Fluttertoast.showToast(msg: "Please select bed time");
                  } else {
                    await saveBedTime("${bedTime?.inMicroseconds}");
                    await saveBedStatus(true);
                    NotificationManger().scheduleNotificationEveryDay(
                        bedTimeNotificationId,
                        MqttUtils().durationToTime(bedTime!),
                        "Bed Time Reminder",
                        "Bed Time");
                    Fluttertoast.showToast(
                        msg: "Bed Time alert set Successfully");
                    Navigator.pop(context);
                    init();
                  }
                },
                text: 'SAVE',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60,
                  color: FlutterFlowTheme.primaryColor,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 50,
                ),
                loading: _loadingButton,
              ),
            ],
          ),
        );
      },
    );
  }
}
