import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guardian/data/constansts.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:intl/intl.dart';

import 'MqttNotifier.dart';


class MqttUtils{
   Color getBatteryColor(String status){
     int? batt = int.tryParse(status)??-1;
      if(batt >  50){
        return MqttGreenColor;
      }else if(batt <= 50 && batt > 20){
        return MqttOrangeColor;
      }else if(batt <= 20){
        return MqttRedColor;
      }else{
        return Colors.grey;
      }
    }

   String getBatteryStatus(String status){
     int? batt = int.tryParse(status)??-1;
     if( batt >  50){
       return "Pendant Battery Is OK";
     }else if(batt <= 50 && batt > 20){
       return "Pendant Battery Is Not OK";
     }else if(batt <= 20){
       return "Pendant Battery Is Critical";
     }else{
       return "Pendant Battery not available";
     }
   }

   Color getPirColor(String status){
     if(status == "1"){
       return MqttGreenColor;
     }else if(status == "0"){
       return MqttRedColor;
     }else{
       return Colors.grey;
     }
   }

   String getPirStatus(String status){
     if(status == "1"){
       return "Pendant In Range";
     }else if(status == "0"){
       return "Pendant Not In Range";
     }else{
       return "Waiting For Pendant Data";
     }
   }

   Color getIntenetColor(String status){
     if(status == "connect"){
       return MqttGreenColor;
     }else if(status == "disconnect"){
       return MqttRedColor;
     }else{
       return Colors.grey;
     }
   }

   String getInternetStatus(String status){
     if(status == "connect"){
       return "Internet Connected";
     }else if(status == "disconnect"){
       return "Internet disconnect";
     }else{
       return "Internet ---";
     }
   }

   String getGauradianConnectedStatus(String status){
     if(status == "connect"){
       return "Guardian Network Connected";
     }else if(status == "disconnect"){
       return "Guardian Network disconnect";
     }else{
       return "Guardian Network ";
     }
   }

   Color getPowerColor(String status){
     if(status == "pressed"){
       return MqttGreenColor;
     }else if(status == "released"){
       return MqttRedColor;
     }else{
       return Colors.grey;
     }
   }

   String getPowerStatus(String status){
     if(status == "pressed"){
       return "Power Connected";
     }else if(status == "released"){
       return "Power Off";
     }else{
       return "Power ---";
     }
   }

   Color getHomeAwayColor(String status){
     if(status == "home"){
       return MqttGreenColor;
     }else if(status == "away"){
       return MqttRedColor;
     }else{
       return Colors.grey;
     }
   }

   String getHomeAwayStatus(String status){
     if(status == "home"){
       return "assets/images/ic_home.svg";
     }else if(status == "away"){
       return "assets/images/ic_away.svg";
     }else{
       return "";
     }
   }


   Color getAreYouOkColor(RuokStatus? status){
     if(status == null){
       return Color(0xffD5D5D5);
     }else if(status == RuokStatus.noset){
       return Color(0xffD5D5D5);
     }else if(status == RuokStatus.announcement1 || status == RuokStatus.announcement2 || status == RuokStatus.announcement3 || status == RuokStatus.announcement4 || status == RuokStatus.announcement5 ||status == RuokStatus.acknowledged){
       return Color(0xffA4D066);
     }else if(status == RuokStatus.noresponse){
       return Color(0xffEC1D24);
     }
     return Color(0xffD5D5D5);
   }

   Widget getAreYouOkWidget(RuokStatus? status,MqttEvent? event){
     if(status == null || event == null){
       return Text(
         'Not Set',
         style: TextStyle(
           color: Colors.white,
           fontSize: 34,
         ),
       );
     }else if(status == RuokStatus.noset){
       return Text(
         'Not Set',
         style: TextStyle(
           color: Colors.white,
           fontSize: 34,
         ),
       );
     }else if(status == RuokStatus.announcement1 || status == RuokStatus.announcement2 || status == RuokStatus.announcement3 || status == RuokStatus.announcement4 || status == RuokStatus.announcement5 ){
       return Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               FaIcon(FontAwesomeIcons.volumeUp,color: Colors.white,),
               SizedBox(width: 6,),
               Text(
                 'Announcing',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 12,
                 ),
               ),
             ],
           ),
           Text(
             '${status.toString().substring(status.toString().length-1,status.toString().length)}',
             style: TextStyle(
               color: Colors.white,
               fontSize: 18,
             ),
           )
         ],
       );
     }else if(status == RuokStatus.acknowledged){
       return Column(
         children: [
           Text(
             'Acknowledged',
             style: TextStyle(
               color: Colors.white,
               fontSize: 19,
             ),
           ),
           Text(
             '${MqttUtils().calculateTimeDifferenceAgo(DateTime.now(),event.dateCreated)}',
             style: TextStyle(
               color: Colors.white,
               fontSize: 10,
             ),
           ),
         ],
       );
     }else if(status == RuokStatus.noresponse){
       return Column(
         children: [
           Text(
             'No Response!',
             style: TextStyle(
               color: Colors.white,
               fontSize: 19,
             ),
           ),
           Text(
             '${MqttUtils().calculateTimeDifferenceAgo(DateTime.now(),event.dateCreated)}',
             style: TextStyle(
               color: Colors.white,
               fontSize: 10,
             ),
           )
         ],
       );
     }
     return Container();
   }

   String dateTimeToFormat(DateTime? dateTime){
     if(dateTime != null){
       return DateFormat("yyyy-MM-dd").format(dateTime);
     }
   return "";
   }

   String dateTimeToTimeFormat(DateTime? dateTime){
     if(dateTime != null){
       return DateFormat("hh:mm:ss").format(dateTime);
     }
     return "";
   }

   String calculateTimeDifferenceBetween( DateTime? startDate,  DateTime? endDate) {
     if(startDate == null || endDate == null){
       return "0 min";
     }
     int seconds = endDate.difference(startDate).inSeconds;
     if (seconds < 60)
       return '$seconds second';
     else if (seconds >= 60 && seconds < 3600)
       return '${startDate.difference(endDate).inMinutes.abs()} minute';
     else if (seconds >= 3600 && seconds < 86400)
       return '${startDate.difference(endDate).inHours} hour';
     else
       return '${startDate.difference(endDate).inDays} day';
   }

   String calculateTimeDifferenceAgo( DateTime? startDate,  DateTime? endDate) {
     if(startDate == null || endDate == null){
       return "0 min";
     }
     int seconds = startDate.difference(endDate).inSeconds;
     if (seconds < 60)
       return 'min ago';
     else if (seconds >= 60 && seconds < 3600)
       return '${startDate.difference(endDate).inMinutes.abs()} min ago';
     else if (seconds >= 3600 && seconds < 86400)
       return '${startDate.difference(endDate).inHours} hrs ago';
     else
       return '${startDate.difference(endDate).inDays} day ago';
   }

   String? calculateTimeDifferenceAgoNew( DateTime? startDate,  DateTime? endDate) {
     if(startDate == null || endDate == null){
       return "Just Now";
     }
     int seconds = startDate.difference(endDate).inSeconds;
     if (seconds < 60) {
       return 'Just Now';
     }else if (seconds >= 60 && seconds < 3600) {
       var minute = startDate
           .difference(endDate)
           .inMinutes
           .abs();
       if(minute == 1  || minute == 2){
         return "1 Min ago";
       }else if(minute >= 3  && minute <= 60){
         return "$minute Mins Ago";
       }
     }else if (seconds >= 3600 && seconds < 86400) {
       var hour = startDate
           .difference(endDate)
           .inHours;
       if(hour == 1  || hour == 2){
         return "1 Hour ago";
       }else if(hour >= 3  && hour <= 60){
         return "$hour Hours Ago";
       }

     }else if (seconds >= 86400 && seconds < 172800) {
      return "Yesterday";
     }else {
       return '${startDate
           .difference(endDate)
           .inDays} Days ago';
     }
   }

   int calculateTimeDifferenceBetweenInMinutes( DateTime? startDate,  DateTime? endDate) {
     if(startDate == null || endDate == null){
       return 0;
     }
     int inMinutes = startDate.difference(endDate).inMinutes;

    return inMinutes;
   }

   int calculateTimeDifferenceBetweenInHour( DateTime? startDate,  DateTime? endDate) {
     if(startDate == null || endDate == null){
       return 0;
     }
     int inMinutes = startDate.difference(endDate).inHours;

     return inMinutes;
   }

   Time durationToTime(Duration duration) {
     String twoDigits(int n) => n.toString().padLeft(2, "0");
     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
     return Time(int.parse(twoDigits(duration.inHours)),int.parse(twoDigitMinutes),int.parse(twoDigitSeconds));
   }

   DateTime durationToDate(Duration duration) {
     String twoDigits(int n) => n.toString().padLeft(2, "0");
     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
     DateTime now = DateTime.now();
     return DateTime(now.year,now.month,now.day,int.parse(twoDigits(duration.inHours)),int.parse(twoDigitMinutes),int.parse(twoDigitSeconds));
   }

   String getFirmwareStatus(String status){
     if(status == "download"){
       return "Download the new firmware from server";
     }else if(status == "available"){
       return "New firmwarwe available on server";
     }else if(status == "update"){
       return "Update the ESS firmware";
     }else{
       return "";
     }
   }
}