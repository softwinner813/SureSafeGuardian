import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian/cubit/login/LoginCubit.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/screens/dashboard/dashboard_widget.dart';
import 'package:guardian/screens/login_screen/login_screen_widget.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';


class SplashWidget extends StatefulWidget {
  SplashWidget({Key? key}) : super(key: key);

  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      curve: Curves.easeIn,
      trigger: AnimationTrigger.onPageLoad,
      duration: 1700,
      fadeIn: true,
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    init();
  }



  init() async {
    bool? isLogin = await getLogin();
    String username = await getUserName();
    String password = await getUserPassword();
    if (isLogin == true) {

        BlocProvider.of<LoginCubit>(context, listen: false)
            .login(
            context, LoginRequest(username: username, password: password));

      // String username = await getUserName();
      // String password = await getUserPassword();
      // FlutterBackgroundService().sendData({
      //   "username": username,
      //   "password": password,
      //   // "context": context as Object
      // });
    }
      Timer(Duration(seconds: 3), () {
        if (isLogin == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardWidget()),
                  (route) => false);
        } else if (isLogin == false) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreenWidget()),
                  (route) => false);
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login-removebg-preview.png',
                    fit: BoxFit.cover,
                  ).animated([animationsMap['imageOnPageLoadAnimation']!])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
