
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/model/login/login_response.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/dashboard/dashboard_widget.dart';
import 'package:guardian/screens/splash/splash.dart';

import 'LoginState.dart';

class LoginCubit extends Cubit<LoginState>{
  Repository _repository = Repository();

  LoginCubit(LoginState state) : super(state);


  init(){
    emit(LoginInitial());
  }

  login(BuildContext context,LoginRequest loginRequest) async {
    emit(LoginLoading());
    try {
      // FlutterBackgroundService().sendData({
      //   "username": loginRequest.username,
      //   "password": loginRequest.password,
      // });

      final response = await _repository.loginUser(context, loginRequest);
      if(response.status == true) {
        emit(LoginSuccess(response: response));
      }else{
        emit(LoginFailed(error: response.message.toString()));
      }
    } catch (e) {
      emit(LoginFailed(error: e.toString()));
    }
  }

  logout(BuildContext context) async {
    emit(LoginLoading());
    try {
      final response = await _repository.logout();
      if(response.runtimeType == bool && response == true) {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => SplashWidget()), (
            route) => false);
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => SplashWidget()), (
          route) => false);
      emit(LoginFailed(error: e.toString()));
    }
  }
}