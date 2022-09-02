import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guardian/cubit/mqtt/MqttCubit.dart';
import 'package:guardian/cubit/mqtt/MqttState.dart';
import 'package:guardian/data/local/DBProvider.dart';
import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/login_request.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttProviderNew.dart';
import 'package:guardian/data/repository.dart';
import 'package:guardian/screens/mqtt/test_screen.dart';
import 'package:guardian/screens/splash/splash.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';


import 'cubit/login/LoginCubit.dart';
import 'cubit/login/LoginState.dart';
import 'data/model/mqtt/mqtt_event.dart';
import 'data/mqtt/MqttProvider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final mqttMain = MqttProvider;
final flutterBackgroundService = FlutterBackgroundService();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterBackgroundService.initialize(onRun);

  MqttProvider.mqtt.client;
  runApp( ChangeNotifierProvider(
    create: (_) => MqttNotifier(),
    child: MyApp(),
  ));
}

void onRun(){
  WidgetsFlutterBinding.ensureInitialized();
  bool isConnected = false;
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    print("recevied events -- > ${event.toString()}");
    if (event!["action"] == "setAsForeground") {
      service.setAsForegroundService();
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setAsForegroundService();
    }

    if (event["action"] == "stopService") {
      service.stopService();
    }

    if(event.keys.contains("username")){
      String username = event['username'];
      String password = event['password'];
     // BuildContext context = event['context'];
      print("event ${event} $username  $password");
      //MqttProviderNew(service).init();
     // MqttProvider(service).connect(LoginRequest(username: username,password: password));
    }

    if(event.keys.contains("mqtt")) {
      print("mqtt service detected");
      Map<String, dynamic> map = event['mqtt'];


      //DBProvider.db.newEventAdded(MqttEvent.fromJson(map));
    }


  });

  service.setAsForegroundService();
  service.setNotificationInfo(
    title: "My App Service",
    content: "Updated at ${DateTime.now()}",
  );

  service.sendData(
    {"current_date": DateTime.now().toIso8601String()},
  );





  //});
}



mqttLoader(context,service)async{
  String username = await getUserName();
  String password = await getUserPassword();
  LoginRequest request = LoginRequest(username: username,password: password);

  await MqttProvider.mqtt.subscribe(username);
  await MqttProvider.mqtt.updateListner(username);
}



class MyApp extends StatelessWidget {

  static const methodChannel = const MethodChannel('com.tarazgroup');


  Future<bool> dbAdd()async{
    print("..........---->from flutter view callback");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    methodChannel.setMethodCallHandler((call){
      return dbAdd();
    });

    return MultiBlocProvider(providers: [
      BlocProvider<LoginCubit>(
        lazy: true,
        create: (context) => LoginCubit(LoginInitial()),
      ),
      BlocProvider<MqttCubit>(
        lazy: true,
        create: (context) => MqttCubit(MqttInitial()),
      ),
    ], child: MaterialApp(
      title: 'New Gaurdian App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashWidget(),
    ));
  }
}
