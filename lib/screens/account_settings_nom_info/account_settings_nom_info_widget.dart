
import 'package:guardian/screens/drawer/Drawer.dart';

import '../components/app_bar_component_widget.dart';
import '../components/bottom_nav_component_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';


class AccountSettingsNomInfoWidget extends StatefulWidget {
  AccountSettingsNomInfoWidget({Key? key}) : super(key: key);

  @override
  _AccountSettingsNomInfoWidgetState createState() =>
      _AccountSettingsNomInfoWidgetState();
}

class _AccountSettingsNomInfoWidgetState
    extends State<AccountSettingsNomInfoWidget> {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late TextEditingController textController5;
  late TextEditingController textController6;
  late TextEditingController textController7;
  late TextEditingController textController8;
  late TextEditingController textController9;
  bool switchListTileValue1 = true;
  bool switchListTileValue2 = true;
  bool switchListTileValue3 = true;
  bool switchListTileValue4 = false;
  bool switchListTileValue5 = true;
  bool switchListTileValue6 = false;
  bool switchListTileValue7 = true;
  bool switchListTileValue8 = true;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    textController5 = TextEditingController();
    textController6 = TextEditingController();
    textController7 = TextEditingController();
    textController8 = TextEditingController();
    textController9 = TextEditingController();
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/images/house.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: Text(
                          'Dorris Smith',
                          style: TextStyle(
                            color: FlutterFlowTheme.primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/Group_943.png',
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Emergency Contact #1',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: TextFormField(
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController2,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 0),
                                  child: TextFormField(
                                    controller: textController3,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Address Line 1',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: TextFormField(
                                    controller: textController4,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Address Line 2',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController5,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Pincode',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: TextFormField(
                                    controller: textController6,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Connection to User',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController7,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Home Telephone Number',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: TextFormField(
                                    controller: textController8,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Mobile Number',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x34000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController9,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Work Number',
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x33000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Alert Notifications',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.max,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //           width: 100,
                        //           height: 40,
                        //           decoration: BoxDecoration(color: Colors.red),
                        //         ), // child: Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(
                        //       0, 0, 8, 0),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(50),
                        //     child: SwitchListTile(
                        //       value: switchListTileValue1 ??= true,
                        //       onChanged: (newValue) => setState(() =>
                        //           switchListTileValue1 = newValue),
                        //       title: Text(
                        //         'User Away  For Too Long',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 10,
                        //         ),
                        //       ),
                        //       tileColor: Color(0xFF56E06E),
                        //       activeColor: Colors.white,
                        //       activeTrackColor: Color(0xFF682929),
                        //       dense: false,
                        //       controlAffinity:
                        //           ListTileControlAffinity.trailing,
                        //       contentPadding:
                        //           EdgeInsetsDirectional.fromSTEB(
                        //               10, 0, 0, 0),
                        //     ),
                        //   ),
                        // ),
                        //       ),
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               8, 0, 0, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue2 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue2 = newValue),
                        //               title: Text(
                        //                 'Home Temperature',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFB42629),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF682929),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 2, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue1
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'User Away  For Too Long',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue1,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue1 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 0, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue2
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'User Away  For Too Long',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue2,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue2 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.max,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               0, 0, 8, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue3 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue3 = newValue),
                        //               title: Text(
                        //                 'I\'m Ok Check',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFB42629),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF9A2C2C),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //               contentPadding:
                        //                   EdgeInsetsDirectional.fromSTEB(
                        //                       10, 0, 0, 0),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               8, 0, 0, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue4 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue4 = newValue),
                        //               title: Text(
                        //                 'Activity Alert',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFFA7575),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF682929),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 2, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue3
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'I\'m Ok Check',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue3,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue3 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 0, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue4
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'Activity Alert',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue4,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue4 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.max,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               0, 0, 8, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue5 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue5 = newValue),
                        //               title: Text(
                        //                 'Normal Get Up Time',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFB42629),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF682929),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //               contentPadding:
                        //                   EdgeInsetsDirectional.fromSTEB(
                        //                       10, 0, 0, 0),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               8, 0, 0, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue6 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue6 = newValue),
                        //               title: Text(
                        //                 'Normal Bed Time',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFB42629),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF682929),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 2, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue5
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'Normal Get Up Time',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue5,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue5 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 0, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue6
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'Normal Bed Time',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue6,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue6 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.max,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               0, 0, 8, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue7 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue7 = newValue),
                        //               title: Text(
                        //                 'Medication Alert',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFB42629),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF682929),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //               contentPadding:
                        //                   EdgeInsetsDirectional.fromSTEB(
                        //                       10, 0, 0, 0),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               8, 0, 0, 0),
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(50),
                        //             child: SwitchListTile(
                        //               value: switchListTileValue8 ??= true,
                        //               onChanged: (newValue) => setState(() =>
                        //                   switchListTileValue8 = newValue),
                        //               title: Text(
                        //                 'Medication Reminder',
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 10,
                        //                 ),
                        //               ),
                        //               tileColor: Color(0xFFFA7575),
                        //               activeColor: Colors.white,
                        //               activeTrackColor: Color(0xFF682929),
                        //               dense: false,
                        //               controlAffinity:
                        //                   ListTileControlAffinity.trailing,
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 2, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue7
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'Medication Alert',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue7,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue7 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 0, 0, 0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: switchListTileValue8
                                          ? Color(0xFFD6D679)
                                          : Color(0xFFC04848),
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
                                          Text(
                                            'Medication Reminder',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Switch(
                                            value: switchListTileValue8,
                                            onChanged: (newValue) => setState(
                                                () => switchListTileValue8 =
                                                    newValue),
                                            activeColor: Colors.white,
                                            activeTrackColor: Color(0xFF682929),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Full Access',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Emergency Contact',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Set Away Time',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'From',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'To',
                                style: TextStyle(
                                  color: FlutterFlowTheme.primaryColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Divider(
                                thickness: 1,
                                indent: 1,
                                color: Color(0x67000000),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFBB2A2A),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Add Another Nominated Contact',
                              style: TextStyle(
                                color: FlutterFlowTheme.primaryColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Save Settings',
                                options: FFButtonOptions(
                                  width: 228,
                                  height: 40,
                                  color: FlutterFlowTheme.primaryColor,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 30,
                                ),
                                loading: _loadingButton,
                              ),
                            )
                          ],
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
