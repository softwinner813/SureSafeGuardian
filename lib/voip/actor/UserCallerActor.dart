import 'package:get/get.dart';
import 'package:guardian/data/sip/NativeSIPApiProvider.dart';

class UserCallerActor{

  NativeSIPApiProvider _nativeSIPApiProvider = NativeSIPApiProvider();


  Future<bool> makeCall(String callerUsername) async {
    bool callingStatus = await _nativeSIPApiProvider.methodChannel.invokeMethod("makeSIPCall",<String, dynamic>{
      "callerUsername": callerUsername
    });
    return callingStatus;
  }


  Future<bool> makeVideoCall(String callerUsername) async {
    bool callingStatus = await _nativeSIPApiProvider.methodChannel.invokeMethod("makeSIPVideoCall",<String, dynamic>{
      "callerUsername": callerUsername
    });
    return callingStatus;
  }


  Future<bool> endCall() async {
    bool callingStatus = await _nativeSIPApiProvider.methodChannel.invokeMethod("endSIPCall");
    return callingStatus;
  }

}