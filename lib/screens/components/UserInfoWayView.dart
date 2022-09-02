import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guardian/data/mqtt/MqttNotifier.dart';
import 'package:guardian/data/mqtt/MqttUtils.dart';
import 'package:provider/provider.dart';
import 'dart:convert' show utf8;

class UserInfoAwayView extends StatefulWidget {
  @override
  _UserInfoAwayViewState createState() => _UserInfoAwayViewState();
}

class _UserInfoAwayViewState extends State<UserInfoAwayView> {



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Consumer<MqttNotifier>(builder: (context,mqtt,build){
          return SvgPicture.asset(MqttUtils().getHomeAwayStatus(mqtt.homeAway?.status??""),width: 20,height: 20,);
        }),


        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Consumer<MqttNotifier>(
            builder: (context,mqtt,child){
              var encoded = utf8.encode(mqtt.username?.name??"");
              var decoded = utf8.decode(encoded);

              return  Text("${decoded}",
                style: TextStyle(
                  color: Color(0xFF2F68A4),
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
              );
            },
          ),
        ),
        Consumer<MqttNotifier>(builder: (context,mqtt,build){
          if(mqtt.mqtt?.status == "online"){
            return  SvgPicture.asset('assets/images/Group_943.svg', fit: BoxFit.cover,);
          }else if(mqtt.mqtt?.status == "offline"){
            return Image.asset("assets/images/Group_942.png",fit: BoxFit.cover);
          }else{
            return SvgPicture.asset('assets/images/Group_943_grey.svg', fit: BoxFit.cover,);
          }
          return Container();
        }),

      ],
    );
  }
}
