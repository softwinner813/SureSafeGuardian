
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/model/login/login_response.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:guardian/data/mqtt/MqttProvider.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/splash/splash.dart';

import '../../main.dart';
import 'MqttState.dart';

class MqttCubit extends Cubit<MqttState>{
  Repository _repository = Repository();

  MqttCubit(MqttState state) : super(state);


  init(context)async{
    print("------ app running in bg init mqtt");
    String username = await getUserName();

    emit(MqttInitial());
  }

  dataUpdated(MqttEvent event)async{
    // if(event.event == "mqtt"){
    //   emit(MqttStateEventMqtt(response: event));
    // }else if(event.event == "temp"){
    //   emit(MqttStateEventTemperature(response: event));
    // }else if(event.event == "ess"){
    //   emit(MqttStateEventEssIAmLife(response: event));
    // }else if(event.event == "ethernet"){
    //   emit(MqttStateEventEthernet(response: event));
    // }
    // emit(MqttDataUpdated(response: event));
  }
}