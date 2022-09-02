import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guardian/cubit/login/LoginCubit.dart';
import 'package:guardian/cubit/login/LoginState.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/mqtt/MqttProvider.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/components/LoadingView.dart';

import '../dashboard/dashboard_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../forget_password_screen/forget_password_screen_widget.dart';
import 'package:flutter/material.dart';


class LoginScreenWidget extends StatefulWidget {
  LoginScreenWidget({Key? key}) : super(key: key);

  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool passwordVisibility = false;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginCubit? loginCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginCubit = BlocProvider.of<LoginCubit>(context, listen: false);
    loginCubit?.init();
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;

    if(IsProduction == false) {
      setState(() {
        usernameController.text = MqttTestUserName;
        passwordController.text = MqttTestPassword;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: BlocConsumer<LoginCubit, LoginState>(
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/login-removebg-preview.png',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 16, 8, 0),
                                  child: TextFormField(
                                    controller: usernameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Serial Number',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 24,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x4A000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x4A000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please enter serial number";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 16, 8, 0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: !passwordVisibility,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 24,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x4A000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x4A000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => passwordVisibility =
                                              !passwordVisibility,
                                        ),
                                        child: Icon(
                                          passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0xFF757575),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Please enter password";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 32, 8, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() => _loadingButton = true);
                                      try {
                                        if (formKey.currentState!.validate()) {
                                          loginCubit?.login(
                                              context,
                                              LoginRequest(
                                                  username:
                                                      usernameController.text,
                                                  password:
                                                      passwordController.text));
                                        }
                                      } finally {
                                        setState(() => _loadingButton = false);
                                      }
                                    },
                                    text: 'Log in',
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
                                ),
                                // Padding(
                                //   padding: EdgeInsetsDirectional.fromSTEB(
                                //       0, 16, 0, 0),
                                //   child: Text(
                                //     'Forgotten Password?',
                                //     style: TextStyle(
                                //       color: FlutterFlowTheme.primaryColor,
                                //       fontWeight: FontWeight.w300,
                                //       fontSize: 18,
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: EdgeInsetsDirectional.fromSTEB(
                                //       0, 8, 0, 0),
                                //   child: InkWell(
                                //     onTap: () async {
                                //       await Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               ForgetPasswordScreenWidget(),
                                //         ),
                                //       );
                                //     },
                                //     child: Text(
                                //       'Reset Now',
                                //       style: TextStyle(
                                //         color: FlutterFlowTheme.primaryColor,
                                //         fontWeight: FontWeight.w600,
                                //         fontSize: 18,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (state is LoginLoading) LoadingView(),
              ],
            );
          },
          listener: (context, state) async{
            if(state is LoginSuccess){
              Fluttertoast.showToast(msg: "Login Successfully");
              await saveLogin(true);
              saveUserName(usernameController.text);
              saveUserPassword(passwordController.text);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardWidget()), (route) => false);
            }else if(state is LoginFailed){
              Fluttertoast.showToast(msg: "Login Failed");
            }
          }),
    );
  }
}
