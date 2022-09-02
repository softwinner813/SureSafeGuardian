import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/shared_pref.dart';

import 'components/UserInfoWayView.dart';
import 'components/app_bar_component_widget.dart';
import 'components/bottom_nav_component_widget.dart';
import 'drawer/Drawer.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userid = "";
  String password = "";
  bool isPasswordShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init()async{
    userid = await getUserName();
    password= await getUserPassword();
    setState(() {
    });
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
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Text(
                            'Profile Details!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: FlutterFlowTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/Group_943.svg',
                                width: 30,
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
                                      'ESS Connection Id : ${userid}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: FlutterFlowTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/Group_943.svg',
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Password: ${isPasswordShow == true ? password : "********"}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: FlutterFlowTheme.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      IconButton(onPressed: (){
                                        setState(() {
                                          isPasswordShow = !isPasswordShow;
                                        });
                                      }, icon: Icon(isPasswordShow == true ? Icons.toggle_on : Icons.toggle_off,color: isPasswordShow == true ?MqttGreenColor : MqttRedColor,))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
