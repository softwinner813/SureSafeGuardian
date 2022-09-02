import 'dart:async';
import 'dart:isolate';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guardian/cubit/login/LoginCubit.dart';
import 'package:guardian/cubit/mqtt/MqttCubit.dart';
import 'package:guardian/cubit/mqtt/MqttState.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/VoipUser.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/data/sip/sip_provider.dart';
import 'package:guardian/screens/activity_alert_dash/activity_alert_dash_widget.dart';
import 'package:guardian/screens/alarm_profile/alarm_profile_widget.dart';
import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/drawer/Drawer.dart';
import 'package:guardian/screens/home_temp_dash/home_temp_dash_widget.dart';
import 'package:guardian/screens/i_m_data_alert_dash/i_m_data_alert_dash_widget.dart';
import 'package:guardian/voip/actor/AuthenticationActor.dart';
import 'package:guardian/voip/actor/UserCallerActor.dart';
import 'package:guardian/voip/utils/permissions.dart';
import 'package:guardian/voip/view/CallScreenView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import '../../main.dart';
import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const simplePeriodicTask = "simplePeriodicTask";

class DashboardWidget extends StatefulWidget {
  DashboardWidget({Key? key}) : super(key: key);



  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}



class _DashboardWidgetState extends State<DashboardWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  MqttCubit? mqttCubit;
  ReceivePort? _receivePort;
  bool isDialLoading = false;
  Timer? timer;
  List<VoipUser> users = [];

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case Workmanager.iOSBackgroundTask:

          break;

        case simplePeriodicTask:
          await Repository().mqttDataLocal(context);
          print("$simplePeriodicTask was executed");
          break;

      }

      return Future.value(true);
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mqttCubit = BlocProvider.of<MqttCubit>(context, listen: false);
    mqttCubit?.init(context);

    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false);

    setState(() {
      Workmanager().registerPeriodicTask(
        "3",
        simplePeriodicTask,
        initialDelay: Duration(seconds: 10),
      );

    });

    timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      await Repository().mqttDataLocal(context);
    });
    _requestPermissions();
    init();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  init()async{
    // String username = await getUserName();
    // String password = await getUserPassword();
    // FlutterBackgroundService().sendData({
    //   "username": username,
    //   "password": password,
    //   // "context": context as Object
    // });
    users = await DBProvider.db.getAllVoipUser();
    setState(() {
    });


  }

  Future<void> _pullRefresh() async {
    mqttCubit?.init(context);
  }
  parseData() async {
    String diff = await Repository().getMqttPirInActiveDuration(context);
    print("diff $diff");
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: DrawerScreen(),
      endDrawerEnableOpenDragGesture: false,
      body: RefreshIndicator(
        onRefresh:_pullRefresh,
        child: BlocConsumer<MqttCubit, MqttState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SafeArea(
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/Group_933.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AppBarComponentWidget(isBackAllow: false,),
                            // TextButton(onPressed: ()async{
                            //   String username = await getUserName();
                            //   String password = await getUserPassword();
                            //   FlutterBackgroundService().sendData({
                            //     "username": username,
                            //     "password": password,
                            //    // "context": context as Object
                            //   });
                            // }, child: Text("Start")),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  UserInfoAwayView(),
                                  InkWell(
                                    onTap: () {
                                      parseData();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      height: 41,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        border: Border.all(
                                          color: Color(0xFF5A5A5A),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Consumer<MqttNotifier>(
                                            builder: (context, mqtt, child) {
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/Group_944.svg',
                                                    width: 9,
                                                    height: 13,
                                                    fit: BoxFit.cover,
                                                    color: MqttUtils()
                                                        .getPirColor(
                                                            mqtt.pir?.status ??
                                                                ""),
                                                  ),
                                                  SizedBox(width: 4,),
                                                  Text(
                                                    '${MqttUtils().getPirStatus(mqtt.pir?.status ?? "")}',
                                                    style: TextStyle(
                                                      color: MqttUtils()
                                                          .getPirColor(
                                                              mqtt.pir?.status ??
                                                                  ""),
                                                      fontSize: 10,
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                          Consumer<MqttNotifier>(
                                              builder: (context, mqtt, child) {
                                            return Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                      0, 4, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/Group_522.svg',
                                                    width: 15,
                                                    height: 10,
                                                    fit: BoxFit.cover,
                                                    color: MqttUtils()
                                                        .getBatteryColor(
                                                            mqtt.battery?.batt ??
                                                                ""),
                                                  ),
                                                  SizedBox(width: 4,),
                                                  Text(
                                                    '${MqttUtils().getBatteryStatus(mqtt.battery?.batt ?? "")} ${mqtt.battery?.batt} %',
                                                    style: TextStyle(
                                                      color: MqttUtils()
                                                          .getBatteryColor(mqtt
                                                                  .battery
                                                                  ?.batt ??
                                                              ""),
                                                      fontSize: 10,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 32, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.push<void>(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeTempDashWidget(),
                                                )),
                                            child: Consumer<MqttNotifier>(
                                                builder: (context, mqtt, child) {
                                              return Container(
                                                width: 150,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color:
                                                      mqtt.temp?.status == "high"
                                                          ? MqttRedColor
                                                          : mqtt.temp?.status ==
                                                                  "normal"
                                                              ? MqttGreenColor
                                                              : MqttBlueColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 6,
                                                      color: Color(0x64000000),
                                                      offset: Offset(0, 8),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(23),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Home Temperature',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${mqtt.temp?.temperature ?? "--"} °c",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 40,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                          Consumer<MqttNotifier>(
                                          builder: (context, mqtt, child) {

                                              return InkWell(
                                                onTap: () => Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          IMDataAlertDashWidget(),
                                                    )),
                                                child: Container(
                                                  width: 150,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: MqttUtils().getAreYouOkColor(mqtt.ruokStatus),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 6,
                                                        color: Color(0x63000000),
                                                        offset: Offset(0, 8),
                                                      )
                                                    ],
                                                    borderRadius:
                                                    BorderRadius.circular(20),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Are You OK?',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      MqttUtils().getAreYouOkWidget(mqtt.ruokStatus,mqtt.ruok),
                                                    ],
                                                  ),
                                                ),
                                              );
                                          }),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.push<void>(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActivityAlertDashWidget(),
                                                )),
                                            child: Consumer<MqttNotifier>(
                                                builder: (context, mqtt, child) {
                                              return Container(
                                                width: 150,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color:
                                                      mqtt.activityTimeExcceded ==
                                                              true
                                                          ? MqttRedColor
                                                          : MqttGreenColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 6,
                                                      color: Color(0x63000000),
                                                      offset: Offset(0, 8),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Recent Activity',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${mqtt.lastPirInActiveDuration}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 19,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),

                                          Consumer<MqttNotifier>(
                                              builder: (context, mqtt, child) {

                                                return InkWell(
                                                  child: Container(
                                                    width: 150,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: MqttUtils().getAreYouOkColor(mqtt.medicationStatus),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 6,
                                                          color: Color(0x63000000),
                                                          offset: Offset(0, 8),
                                                        )
                                                      ],
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          'Medication Reminder',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        MqttUtils().getAreYouOkWidget(mqtt.medicationStatus,mqtt.medication),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Consumer<MqttNotifier>(
                                            builder: (context, mqtt, child) {
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/Group_940.svg',
                                                      width: 30,
                                                      height: 30,
                                                      fit: BoxFit.cover,
                                                      color: MqttUtils()
                                                          .getIntenetColor(mqtt
                                                          .ethernet
                                                          ?.status ??
                                                          ""),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 4, 0, 0),
                                                      child: Text(
                                                        '${MqttUtils().getGauradianConnectedStatus(mqtt.ethernet?.status??"")}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: MqttUtils()
                                                              .getIntenetColor(mqtt
                                                              .ethernet
                                                              ?.status ??
                                                              ""),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          Consumer<MqttNotifier>(
                                              builder: (context, mqtt, child) {
                                            return Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/Group_941.svg',
                                                    width: 30,
                                                    height: 32,
                                                    fit: BoxFit.cover,
                                                    color: MqttUtils()
                                                        .getPowerColor(
                                                            mqtt.power?.status ??
                                                                ""),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 4, 0, 0),
                                                    child: Text(
                                                      '${MqttUtils().getPowerStatus(mqtt.power?.status ?? "")}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: MqttUtils()
                                                            .getPowerColor(mqtt
                                                                    .power
                                                                    ?.status ??
                                                                ""),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                          Consumer<MqttNotifier>(
                                              builder: (context, mqtt, child) {
                                            return Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/Group_939.svg',
                                                    width: 32,
                                                    height: 26,
                                                    fit: BoxFit.cover,
                                                    color: MqttUtils()
                                                        .getIntenetColor(mqtt
                                                                .ethernet
                                                                ?.status ??
                                                            ""),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(0, 4, 0, 0),
                                                    child: Text(
                                                      '${MqttUtils().getInternetStatus(mqtt.ethernet?.status ?? "")}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: MqttUtils()
                                                            .getIntenetColor(mqtt
                                                                    .ethernet
                                                                    ?.status ??
                                                                ""),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 16, 8, 16),
                                      child: FFButtonWidget(
                                        onPressed: () async{
                                          print('Button pressed ...');
                                          //bool isSipLogin = await  SipProvider().sipLoginUser(SIP_USERNAME,SIP_PASSWORD,SIP_SERVER);
                                          //print("sip login ${isSipLogin}");

                                          if(users.length == 0 ){
                                            //Fluttertoast.showToast(msg: "Please register SIP profile");
                                            Fluttertoast.showToast(msg: "VOIP coming soon for iOS");
                                          }else {
                                            Map<Permission,
                                                PermissionStatus> statuses = await [
                                              Permission.contacts,
                                              Permission.camera,
                                              Permission.microphone
                                            ].request();
                                            if (!await Permission.contacts
                                                .isGranted) {
                                              openAppSettings();
                                            }
                                            if (!await Permission.contacts
                                                .isGranted) {
                                              openAppSettings();
                                            } else if (!await Permission.camera
                                                .isGranted) {
                                              openAppSettings();
                                            } else
                                            if (!await Permission.microphone
                                                .isGranted) {
                                              openAppSettings();
                                            } else {
                                              setState(() {
                                                isDialLoading = true;
                                              });
                                              print("login init");
                                              int voipId = await getVoipUser();
                                              VoipUser? voipUser = await DBProvider
                                                  .db.getVoIPUser(voipId);
                                              bool signedIn = await AuthenticationActor()
                                                  .login(
                                                "${voipUser?.username}",
                                                "${voipUser?.password}",
                                                "sip.call4help.uk",);
                                              print("voip login in  $signedIn");
                                              Fluttertoast.showToast(
                                                  msg: "VoIP login status $signedIn");

                                              setState(() {
                                                isDialLoading = false;
                                              });
                                              if (signedIn) {
                                                String username = await getUserName();
                                                var responseCalling = await UserCallerActor()
                                                    .makeCall(username);
                                                print(
                                                    "Call Status-------> $responseCalling");
                                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreenView(name: "${voipUser?.name}",mobileNumber: "${voipUser?.username}",)));
                                              }
                                            }
                                          }

                                        },
                                        text: 'DIAL IN',
                                        options: FFButtonOptions(
                                          width: double.infinity,
                                          height: 60,
                                          color: users.length == 0 ? Color(0xffd5d5d5) : Color(0xFF2F68A4),
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius: 50,
                                        ),
                                        loading: isDialLoading,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 16),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              setState(
                                                  () => _loadingButton2 = true);
                                              try {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AlarmProfileWidget(),
                                                  ),
                                                );
                                              } finally {
                                                setState(() =>
                                                    _loadingButton2 = false);
                                              }
                                            },
                                            text: 'Alarm Profile',
                                            options: FFButtonOptions(
                                              width: 150,
                                              height: 30,
                                              color: Color(0xFF2F68A4),
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 50,
                                            ),
                                            loading: _loadingButton2,
                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Consumer<MqttNotifier>(
                                          builder: (context, mqtt, child) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 0),
                                              child: Center(
                                                  child: Text(
                                                      "App ${mqtt.mqtt?.version ?? "        "}",style: TextStyle(fontSize: 12,color: Color(0xff2f68A4)))),
                                            );
                                          },
                                        ),
                                        Consumer<MqttNotifier>(
                                          builder: (context, mqtt, child) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 0),
                                              child: Text(
                                                "System ${mqtt.mqtt?.ess ?? "        "} ",style: TextStyle(fontSize: 12,color: Color(0xff2f68A4)),),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Consumer<MqttNotifier>(
                                          builder: (context, mqtt, child) {
                                            return mqtt != null
                                                ? Container(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 0),
                                              child: Text(
                                                "${MqttUtils().getFirmwareStatus(mqtt.fireware?.status??"")}",style: TextStyle(fontSize: 12,color: mqtt.fireware?.status == "" ?  Color(0xff2f68A4) : Colors.red),),
                                            )
                                                : Container();
                                          },
                                        ),

                                      ],),
                                    SizedBox(height: 16,),
                                  ],
                                ),
                              ),
                            ),
                            BottomNavComponentWidget()
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            listener: (context, state) {}),
      ),
    );
  }

  Widget ruOKAnnounce(String count,bool isMedication){
   return InkWell(
      onTap: () =>
          Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    IMDataAlertDashWidget(),
              )),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xffA5D065),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(
                  0x63000000),
              offset: Offset(0, 8),
            )
          ],
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize
              .max,
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              '${isMedication ? "Medication Reminder" : "Are You OK?"}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.volumeUp,color: Colors.white,),
                SizedBox(width: 6,),
                Text(
                  'Announcing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              '$count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ruOKAcknowledge(bool isMedicationReminder){
    return InkWell(
      onTap: () =>
          Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    IMDataAlertDashWidget(),
              )),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xffA5D065),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(
                  0x63000000),
              offset: Offset(0, 8),
            )
          ],
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize
              .max,
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              '${isMedicationReminder ? "Medication Reminder" : "Are You OK?"}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Acknowledged',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
            Text(
              '1 min ago',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ruOKNoResponse(bool isMedicationReminder){
    return InkWell(
      onTap: () =>
          Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    IMDataAlertDashWidget(),
              )),
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xffED1A23),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(
                  0x63000000),
              offset: Offset(0, 8),
            )
          ],
          borderRadius:
          BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize
              .max,
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              '${isMedicationReminder ? "Medication Reminder" : "Are You OK?"}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'No Response!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
            Text(
              '1 min ago',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
