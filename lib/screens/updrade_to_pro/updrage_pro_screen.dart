import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/drawer/Drawer.dart';
import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';


class UpgradeToProWidget extends StatefulWidget {
  UpgradeToProWidget({Key? key}) : super(key: key);

  @override
  _UpgradeToProWidgetState createState() => _UpgradeToProWidgetState();
}

class _UpgradeToProWidgetState extends State<UpgradeToProWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Text(
                            'Guardian Plus Plan!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff3972A9),
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Container(
                            width: 100,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color(0xffD7F0EF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Guardian Plus Plan',
                                      style: TextStyle(
                                        color: Color(0xff3972A9),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    // Text(
                                    //   '£4.99 p/m',
                                    //   style: TextStyle(
                                    //     color: Color(0xff3972A9),
                                    //     fontSize: 36,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   'or £49.99 p/a',
                                    //   style: TextStyle(
                                    //     color: Color(0xff79C9E7),
                                    //     fontWeight: FontWeight.w400,
                                    //     fontSize: 14,
                                    //   ),
                                    // )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'To Upgrade',
                                      style: TextStyle(
                                        color: Color(0xff3972A9),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Contact SureSafe',
                                      style: TextStyle(
                                        color: Color(0xff3972A9),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '*This upgrade is not a part of app feature \n upgrades.  This upgrade makes your \n hardware capable of sending the \n below mentioned data to the application',
                                      style: TextStyle(
                                        color: Color(0xff3972A9),
                                        fontSize: 8,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsetsDirectional.fromSTEB(
                                    //       0, 8, 0, 0),
                                    //   child: FFButtonWidget(
                                    //     onPressed: () {
                                    //       const url="https://personalalarms.org/guardian-subscription";
                                    //       launch(url);
                                    //     },
                                    //     text: 'contact SureSafe',
                                    //     options: FFButtonOptions(
                                    //       width: 100,
                                    //       height: 30,
                                    //       color: Color(0xff3972A9),
                                    //       textStyle: TextStyle(
                                    //         color: Colors.white.withOpacity(0.8),
                                    //       ),
                                    //       borderSide: BorderSide(
                                    //         color: Colors.transparent,
                                    //         width: 1,
                                    //       ),
                                    //       borderRadius: 16,
                                    //     ),
                                    //     loading: _loadingButton,
                                    //   ),
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Text("What's Included?",
                                style: TextStyle(
                                  color: Color(0xff2B67A3),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ))),
                        whatsNew("I'm OK check in"),
                        whatsNew("Wake-up check"),
                        whatsNew("Unusual night-time activity"),
                        whatsNew("High or low home temperature alerts"),
                        whatsNew("Medication reminders"),
                        whatsNew("Add up to 5 nominated contacts"),
                        whatsNew("Dial into base unit from app"),
                        whatsNew("In-app alerts"),
                        whatsNew("System & pendant alerts"),
                        Padding(
                          padding: const EdgeInsets.only(left: 32,top: 3,bottom: 16),
                          child: Text("+ many more features!",style: TextStyle(
                            color: Color(0xff316AA5),
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                          ),),
                        )
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
    );
  }

  Widget whatsNew(String title){
    return  Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/Group_943.svg',
            width: 24,
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
            EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff3972A9),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
