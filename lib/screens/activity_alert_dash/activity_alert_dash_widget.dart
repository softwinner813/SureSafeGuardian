import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/components/LoadingView.dart';
import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/drawer/Drawer.dart';
import 'package:provider/provider.dart';
import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class ActivityAlertDashWidget extends StatefulWidget {
  ActivityAlertDashWidget({Key? key}) : super(key: key);

  @override
  _ActivityAlertDashWidgetState createState() =>
      _ActivityAlertDashWidgetState();
}

class _ActivityAlertDashWidgetState extends State<ActivityAlertDashWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<MqttEvent> events = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  init()async{
    events = await Repository().getMqttPirList(context);
    setState(() {
    });
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
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                AppBarComponentWidget(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: UserInfoAwayView(),
                ),
                Consumer<MqttNotifier>(builder: (context,mqtt,child){
                  return   Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Activity Alert',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                  child: Text(
                                    'Last updated ${events.length != 0 ? MqttUtils().dateTimeToFormat(events.first.dateCreated) : ""}',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.primaryColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 4, 16, 16),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: '${ events.length != 0 ? MqttUtils().dateTimeToTimeFormat(events.first.dateCreated) : ""}',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 50,
                                      color: Color(0xFFB0B051),
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 50,
                                    ),
                                    loading: _loadingButton,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: FlutterFlowTheme.primaryColor,
                                  ),
                                ),
                                Text(
                                  'Time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: FlutterFlowTheme.primaryColor,
                                  ),
                                ),
                                Text(
                                  'Motion Detected?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: FlutterFlowTheme.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Container(
                              width: 100,
                              height: 1,
                              decoration: BoxDecoration(
                                color: Color(0x80000000),
                              ),
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: events.length,
                                itemBuilder: (context,index){
                                  MqttEvent? mqttEvent = events[index];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${MqttUtils().dateTimeToFormat(mqttEvent.dateCreated)}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: FlutterFlowTheme.primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                                              child: Text(
                                                '${MqttUtils().dateTimeToTimeFormat(mqttEvent.dateCreated)}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.primaryColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 64, 0),
                                              child: Image.asset(
                                                (mqttEvent.event == "iamlife" || mqttEvent.status == "1") ?  'assets/images/Group_943.png' : 'assets/images/Group_942.png' ,
                                                width: 12,
                                                height: 12,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )

                        ],
                      ),
                    ),
                  );
                }),
                BottomNavComponentWidget()
              ],
            )
          ],
        ),
      ),
    );
  }
}
