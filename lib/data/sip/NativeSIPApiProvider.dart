import 'package:flutter/services.dart';

class NativeSIPApiProvider{
  final _packageName = "methods";
  late MethodChannel _methodChannel;

  get methodChannel => _methodChannel;

  NativeSIPApiProvider(){
    _methodChannel =  MethodChannel(_packageName);
  }

}