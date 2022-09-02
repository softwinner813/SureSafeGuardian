
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guardian/screens/components/UserInfoWayView.dart';
import 'package:guardian/screens/drawer/Drawer.dart';

import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


class AlarmProfileWidget extends StatefulWidget {
  AlarmProfileWidget({Key? key}) : super(key: key);

  @override
  _AlarmProfileWidgetState createState() => _AlarmProfileWidgetState();
}

class _AlarmProfileWidgetState extends State<AlarmProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _wristURL() async{
    const url = 'https://personalalarms.org/products/guardianwristband';
    await launch(url);
  }
  _pendantURL() async{
    const url = 'https://personalalarms.org/products/guardianpendant';
    await launch(url);
  }
  _activityURL() async{
    const url = 'https://personalalarms.org/guardian-coming-soon';
    await launch(url);
  }
  _dummyURL() async{
    const url = 'https://personalalarms.org/guardian-coming-soon';
    await launch(url,forceWebView: true, enableJavaScript: true,);
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
              mainAxisSize: MainAxisSize.max,
              children: [
                AppBarComponentWidget(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                  child: UserInfoAwayView(),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Alarm Profile',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 158,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFacd470),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color: Color(0xB7000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
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
                                                    14, 0, 14, 0),
                                            child: Text(
                                              'Gaurdian Base Unit',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 158,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFacd470),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color: Color(0xB7000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
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
                                                    14, 0, 14, 0),
                                            child: Text(
                                              'Pendant #1',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 148,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF16060),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Additonal Pendant',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Container(
                                      width: 74,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A26ED),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(

                                            onTap: () async {

                                               await _pendantURL();

                                            },
                                            child:  Text(
                                               'Buy Now',

                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                          // Text(
                                          //   'Buy Now',
                                          //
                                          //   style: TextStyle(
                                          //     color: Colors.white,
                                          //     fontWeight: FontWeight.w300,
                                          //     fontSize: 12,
                                          //   ),
                                          // ),
                                          //https://www.youtube.com/watch?v=cSR34CNXLvo - Yutorial

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 148,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF16060),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Additional Wristband',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Container(
                                      width: 74,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A26ED),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(

                                            onTap: () async {

                                              await _wristURL();

                                            },
                                            child:  Text(
                                              'Buy Now',

                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 148,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF16060),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Activity Monitor Alarm',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Container(
                                      width: 74,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A26ED),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(

                                            onTap: () async {

                                              await _activityURL();

                                            },
                                            child:  Text(
                                              'Buy Now',

                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 148,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF16060),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Fall Detector',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Container(
                                      width: 74,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A26ED),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(

                                            onTap: () async {

                                              await _activityURL();

                                            },
                                            child:  Text(
                                              'Coming Soon',

                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 148,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF16060),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Voice Extender',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: Container(
                                      width: 74,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1A26ED),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(

                                            onTap: () async {

                                              await _activityURL();

                                            },
                                            child:  Text(
                                              'Coming Soon',

                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                        //       Column(
                        //         mainAxisSize: MainAxisSize.max,
                        //         children: [
                        //           Container(
                        //             width: 148,
                        //             height: 40,
                        //             decoration: BoxDecoration(
                        //               color: Color(0xFFF16060),
                        //               borderRadius: BorderRadius.circular(20),
                        //             ),
                        //             child: Column(
                        //               mainAxisSize: MainAxisSize.max,
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   'Home Security System',
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 14,
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsetsDirectional.fromSTEB(
                        //                 0, 8, 0, 0),
                        //             child: Container(
                        //               width: 74,
                        //               height: 24,
                        //               decoration: BoxDecoration(
                        //                 color: Color(0xFF1A26ED),
                        //                 borderRadius: BorderRadius.circular(20),
                        //               ),
                        //               child: Column(
                        //                 mainAxisSize: MainAxisSize.max,
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     'Buy Now',
                        //                     style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.w300,
                        //                       fontSize: 12,
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.max,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Column(
                        //         mainAxisSize: MainAxisSize.max,
                        //         children: [
                        //           Container(
                        //             width: 148,
                        //             height: 40,
                        //             decoration: BoxDecoration(
                        //               color: Color(0xFFF16060),
                        //               borderRadius: BorderRadius.circular(20),
                        //             ),
                        //             child: Column(
                        //               mainAxisSize: MainAxisSize.max,
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   'Dementia Safe',
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 14,
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsetsDirectional.fromSTEB(
                        //                 0, 8, 0, 0),
                        //             child: Container(
                        //               width: 74,
                        //               height: 24,
                        //               decoration: BoxDecoration(
                        //                 color: Color(0xFF1A26ED),
                        //                 borderRadius: BorderRadius.circular(20),
                        //               ),
                        //               child: Column(
                        //                 mainAxisSize: MainAxisSize.max,
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     'Buy Now',
                        //                     style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.w300,
                        //                       fontSize: 12,
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       )
                            ],
                          ),
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
}
