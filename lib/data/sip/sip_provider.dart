import 'NativeSIPApiProvider.dart';

class SipProvider{
  NativeSIPApiProvider _nativeSIPApiProvider = NativeSIPApiProvider();


  Future<bool> sipLoginUser(String username,String password,String server)async{
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
}