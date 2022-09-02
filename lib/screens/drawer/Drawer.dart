import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guardian/cubit/login/LoginCubit.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:guardian/screens/account_settings_nom_info/account_settings_nom_info_widget.dart';
import 'package:guardian/screens/activity_alert/activity_alert_widget.dart';
import 'package:guardian/screens/alarm_profile/alarm_profile_widget.dart';
import 'package:guardian/screens/call_history_data_log/call_history_data_log_widget.dart';
import 'package:guardian/screens/dashboard/dashboard_widget.dart';
import 'package:guardian/screens/medicine_reminder/medicine_reminder_widget.dart';
import 'package:guardian/screens/profile_screen.dart';
import 'package:guardian/screens/splash/splash.dart';
import 'package:guardian/screens/updrade_to_pro/updrage_pro_screen.dart';
import 'package:guardian/screens/voip_profile/voip_profiles.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Color(0xff2F68A4)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Consumer<MqttNotifier>(builder: (context,mqtt,child){
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/ic_logo.png"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: Text(
                            '${mqtt.username?.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),

            SizedBox(
              height: 48,
            ),
            InkWell(
              onTap: () {
                Navigator.push<void>(context,
                    MaterialPageRoute(builder: (context) {
                  return DashboardWidget();
                }));
              },
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),

            drawerItem("Set Alerts", () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                    return ActivityAlertWidget();
                  }));
            }),

            // drawerItem("Medication Reminder", () {
            //   Navigator.push<void>(context,
            //             MaterialPageRoute(builder: (context) {
            //           return MedicineReminderWidget();
            //         }));
            // }),

            drawerItem("Event History Log", () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                    return CallHistoryDataLogWidget();
                  }));
            }),

            // drawerItem("Guardian Plus Plan", () {
            //   Navigator.push<void>(context,
            //       MaterialPageRoute(builder: (context) {
            //         return UpgradeToProWidget();
            //       }));
            // }),

            drawerItem("Alarm Profiles", () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                    return AlarmProfileWidget();
                  }));
            }),

            drawerItem("VoIP Profiles", () {
              // Navigator.push<void>(context,
              //     MaterialPageRoute(builder: (context) {
              //       return VoipProfilesView();
              //     }));
              Fluttertoast.showToast(msg: "Coming Soon For iOS");
            }),

            drawerItem("User Guides", () {
              const url="https://personalalarms.org/user-guides";
              launch(url);
            }),




            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push<void>(context,
            //           MaterialPageRoute(builder: (context) {
            //         return AccountSettingsNomInfoWidget();
            //       }));
            //     },
            //     child: Text(
            //       'Emergency Contacts',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 14,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            //   child: Text(
            //     'Pendant User Information',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w300,
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            // InkWell(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
            //   },
            //   child: Padding(
            //     padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            //     child: Text(
            //       'My Details',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 14,
            //       ),
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push<void>(context,
            //           MaterialPageRoute(builder: (context) {
            //         return AlarmProfileWidget();
            //       }));
            //     },
            //     child: Text(
            //       'Alarm Profile',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 14,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            //   child: Text(
            //     'Tutorial/Help',
            //     style: TextStyle(
            //       color: Colors.grey,
            //       fontWeight: FontWeight.w300,
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 32),
              child: InkWell(
                onTap: ()async{
                  logoutAlertDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.signOutAlt,color: Colors.white.withOpacity(0.9),),
                    SizedBox(width: 8,),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(String title,Function() onclick){
    return  Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: InkWell(
        onTap: onclick,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  logoutAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget backgroundRun = TextButton(
      child: Text("Background Run"),
      onPressed:  () {
        SystemNavigator.pop();
      },
    );
    Widget logout = TextButton(
      child: Text("Logout"),
      onPressed:  () async{
        var isRunning =
        await FlutterBackgroundService().isRunning();
        if (isRunning) {
          FlutterBackgroundService().sendData(
            {"action": "stopService"},
          );
        }
        await saveLogin(false);
        BlocProvider.of<LoginCubit>(context,listen: false).logout(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure logout or run on background"),
      actions: [
        cancelButton,
        backgroundRun,
        logout
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
