import 'package:guardian/data/sip/NativeSIPApiProvider.dart';

class AuthenticationActor  {



  NativeSIPApiProvider _nativeSIPApiProvider = NativeSIPApiProvider();



  Future<bool> login(String username, String password, String server) async{
    bool loggedInStatus = false;
//      loggedInStatus = await MethodChannel(PACKAGE_NAME).invokeMethod("loginSIP",<String,dynamic>{
    loggedInStatus = await _nativeSIPApiProvider.methodChannel.invokeMethod("loginSIP",<String,dynamic>{
      "username": username,
      "password": password,
      "serverURI": server
    });
    print("login response -----> ${loggedInStatus}");
    return loggedInStatus;
  }



  String getSIPUri(String username, String serverAddress) {
    return "$username@$serverAddress";
  }
}
