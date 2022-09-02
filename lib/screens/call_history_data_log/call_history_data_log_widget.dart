import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/components/LoadingView.dart';
import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/drawer/Drawer.dart';

import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';


class CallHistoryDataLogWidget extends StatefulWidget {
  CallHistoryDataLogWidget({Key? key}) : super(key: key);

  @override
  _CallHistoryDataLogWidgetState createState() =>
      _CallHistoryDataLogWidgetState();
}

class _CallHistoryDataLogWidgetState extends State<CallHistoryDataLogWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<MqttEvent?>? snapshot = [];
  List<MqttEvent?>? snapshot1 = [];
  List<MqttEvent?>? snapshot2 = [];
  List<MqttEvent?>? snapshot3 = [];
  int activeTabIndex = 0;
  _fetchMqtt() async{
    setState(() {
    });
    snapshot = await Repository().getMqttdiallist(context);
  }
  _fetchMqtt1() async{
    setState(() {
    });
    snapshot1 = await Repository().getMqttTempList(context);
  }
  _fetchMqtt2() async{
    setState(() {
    });
    snapshot2 = await Repository().getMqttRuokList(context);
  }
  _fetchMqtt3() async{
    setState(() {
    });
    snapshot3 = await Repository().getMqttPirList(context);
  }
  @override
  void initState() {

    super.initState();
    _fetchMqtt();
    _fetchMqtt1();
    _fetchMqtt2();
    _fetchMqtt3();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: DrawerScreen(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Group_933.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                AppBarComponentWidget(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: UserInfoAwayView(),
                ),
                Expanded(child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      activeTabIndex = 0;
                                    });
                                  },
                                  child: Container(
                                    width: 148,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: activeTabIndex == 0 ? Color(0xFF9A3CDC) : Color(0xFFD8B0F2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                          child: Text(
                                            'Call History',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      activeTabIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    width: 168,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: activeTabIndex == 1 ? Color(0xFF9A3CDC) : Color(0xFFD8B0F2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 0),
                                          child: Text(
                                            'Home Temperature',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  activeTabIndex = 2;
                                });
                              },
                              child: Container(
                                width: 148,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: activeTabIndex == 2 ? Color(0xFF9A3CDC) : Color(0xFFD8B0F2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Text(
                                        'I\'m Ok Check',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  activeTabIndex = 3;
                                });
                              },
                              child: Container(
                                width: 168,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: activeTabIndex == 3 ? Color(0xFF9A3CDC) : Color(0xFFD8B0F2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      child: Text(
                                        'Activity Alert',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      DataTable(columns: [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Status')),
                      ],

                          rows:
                          (activeTabIndex == 0 ?
                          snapshot?.map(
                            ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text("${MqttUtils().dateTimeToFormat(element?.dateCreated)}")),
                                DataCell(Text("${MqttUtils().dateTimeToTimeFormat(element?.dateCreated)}")),
                                DataCell(Text("Call ${element?.status??""}")),

                              ],
                            )),
                          )?.toList() ?? [] : (
                              activeTabIndex == 1 ? snapshot1?.map(
                                ((element) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text("${MqttUtils().dateTimeToFormat(element?.dateCreated)}")),
                                    DataCell(Text("${MqttUtils().dateTimeToTimeFormat(element?.dateCreated)}")),
                                    DataCell(Text("${element?.temperature??"--"}°c")),

                                  ],
                                )),
                              )?.toList() ?? [] :
                              (
                                  activeTabIndex == 2 ?  snapshot2?.map(
                                      ((element) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text("${MqttUtils().dateTimeToFormat(element?.dateCreated)}")),
                                          DataCell(Text("${MqttUtils().dateTimeToTimeFormat(element?.dateCreated)}")),
                                          DataCell(
                                            Image.asset((element?.event == "ruok" || element?.status == "responded") ?  'assets/images/Group_943.png' : 'assets/images/Group_942.png', width: 12,
                                              height: 12,
                                              fit: BoxFit.cover,),

                                          ),

                                        ],
                                      )),
                                  )?.toList() ?? [] :
                                  (
                                      activeTabIndex == 3 ? snapshot3?.map(
                                        ((element) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text("${MqttUtils().dateTimeToFormat(element?.dateCreated)}")),
                                            DataCell(Text("${MqttUtils().dateTimeToTimeFormat(element?.dateCreated)}")),
                                            DataCell(
                                              Image.asset((element?.event == "iamlife" || element?.status == "1") ? 'assets/images/Group_943.png'   : 'assets/images/Group_942.png', width: 12,
                                                height: 12,
                                                fit: BoxFit.cover,),

                                            ),

                                          ],
                                        )),
                                      )?.toList() ?? [] :
                                      []
                                  )
                              )
                          ) )

                      )],
                  ),
                ))


                //BottomNavComponentWidget()
              ],
            )
          ],
        ),
      ),
    );
  }
}