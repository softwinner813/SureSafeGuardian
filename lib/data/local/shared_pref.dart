import 'package:shared_preferences/shared_preferences.dart';

Future<bool?> getLogin() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("login") != null
      ? preferences.getBool("login")
      : false;
}

Future<bool> saveLogin(bool isLogin) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("login", isLogin);
}

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("token") ?? "";
}

Future<bool> saveToken(String token) async {
  print("token saved $token");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("token", token);
}

Future<bool> getIntroShow() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("intro_show") ?? true;
}

Future<bool> saveIntroShow(bool show) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("intro_show", show);
}

Future<String> getUserName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("username") ?? "";
}

Future<bool> saveUserName(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("username", name);
}

Future<String> getUserPassword() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("password") ?? "";
}

Future<bool> saveUserPassword(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("password", name);
}


Future<String> getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("userId") ?? "";
}

Future<bool> saveUserId(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("userId", name);
}

Future<String> getTagLine() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("tagline") ?? "";
}

Future<bool> saveTagLine(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("tagline", name);
}

Future<List<String>> getPopularSearch() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getStringList("search") ?? [];
}

Future<bool> savePopularSearch(List<String> popularSearchList) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setStringList("search", popularSearchList);
}

Future<String> getI18n(String key) async {
  String data = "";
  print("language key $key");
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }catch(e){
      print("language exception $key");
  }
  return data;
}

Future<bool> saveI18n(String key,String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString(key, name);
}

Future<String> getLangCode() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("lang") ?? "En";
}

Future<bool> saveLangCode(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("lang", name);
}

Future<String> getFirebaseToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("firebaseID") ?? "";
}

Future<bool> saveFirebaseToken(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("firebaseID", name);
}


Future<bool> getWakeUpStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("wakeupStatus") ?? false;
}

Future<bool> saveWakeUpStatus(bool wakeUpStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("wakeupStatus", wakeUpStatus);
}

Future<String> getWakeUpTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("wakeupTime") ?? "27000000000";
}

Future<bool> saveWakeUpTime(String wakeUpTime) async {
  print("wake up time save $wakeUpTime");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("wakeupTime", wakeUpTime);
}



Future<bool> getBedStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("bedStatus") ?? false;
}

Future<bool> saveBedStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("bedStatus", bedStatus);
}

Future<String> getBedTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("bedTime") ?? "79200000000";
}

Future<bool> saveBedTime(String bedTime) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("bedTime", bedTime);
}

//activity alert
Future<bool> getActivityAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("activityAlertStatus") ?? false;
}

Future<bool> saveActivityAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("activityAlertStatus", bedStatus);
}

Future<int> getActivityAlertTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("activityAlertTime") ?? 15;
}

Future<bool> saveActivityAlertTime(int activityTime) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("activityAlertTime", activityTime);
}

//home temp
Future<bool> getHomeTempAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("homeTempStatus") ?? false;
}

Future<bool> saveHomeTempAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("homeTempStatus", bedStatus);
}

Future<List<String>> getHomeTempAlertRange() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getStringList("homeTempRange")?? ["15.0","26.0"];
}

Future<bool> saveHomeTempAlertRange(List<String> range) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setStringList("homeTempRange", range);
}

//user away
Future<bool> getUserAwayAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("userAwayStatus") ?? false;
}

Future<bool> saveUserAwayAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("userAwayStatus", bedStatus);
}

Future<int> getUserAwayAlertTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("userAwayTime")?? 8;
}

Future<bool> saveUserAwayAlertTime(int time) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("userAwayTime", time);
}

//alarm alert
Future<bool> getAlarmCallAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("alarmAlertStatus") ?? false;
}

Future<bool> saveAlarmCallAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("alarmAlertStatus", bedStatus);
}

//pendant
Future<bool> getPendantRangeAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("pendantOutRangeStatus") ?? false;
}

Future<bool> savePendantRangeAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("pendantOutRangeStatus", bedStatus);
}

Future<int> getPendantRangeAlertTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("pendantOutRangeTime")?? 8;
}

Future<bool> savePendantRangeAlertTime(int time) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("pendantOutRangeTime", time);
}

//low battery
Future<bool> getLowBatteryAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("lowBatteryAlertStatus") ?? false;
}

Future<bool> saveLowBatteryAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("lowBatteryAlertStatus", bedStatus);
}


//night time
Future<bool> getNightTimeAlertExceedAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("nightTimeExceed") ?? false;
}

Future<bool> saveNightTimeAlertExceedAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("nightTimeExceed", bedStatus);
}


//got up time
Future<bool> getWakeTimeAlertExceedAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("wakeTimeExceed") ?? false;
}

Future<bool> saveWakeTimeAlertExceedAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("wakeTimeExceed", bedStatus);
}

//lack of moment
Future<bool> getLackOfMomentAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("lackOfMomentStatus") ?? false;
}

Future<bool> saveLackOfMomentStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("lackOfMomentStatus", bedStatus);
}

Future<int> getLackOfMomentTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("lackOfMomentTime") ?? 15;
}

Future<bool> saveLackOfMomentTime(int activityTime) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("lackOfMomentTime", activityTime);
}


//gaurdian network
Future<bool> getGaurdianNetworkAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("gaurdianNetworkStatus") ?? false;
}

Future<bool> saveGaurdianNetworkAlertStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("gaurdianNetworkStatus", bedStatus);
}


//power status
Future<bool> getPowerStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("powerStaus") ?? false;
}

Future<bool> savePowerStatus(bool bedStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("powerStaus", bedStatus);
}



//internet status
Future<bool> getInternetStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("internetStatus") ?? false;
}

Future<bool> saveInternetStatus(bool internetStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("internetStatus", internetStatus);
}


//fireware status
Future<bool> getFirewareUpdateStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("firewareStatus") ?? false;
}

Future<bool> saveFirewareUpdateStatus(bool fireware) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("firewareStatus", fireware);
}


//voip default user
Future<int> getVoipUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("voipUser") ?? 0;
}

Future<bool> saveVoipUser(int userId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("voipUser", userId);
}


Future<String> getMqttStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("mqtt") ?? "disconnected";
}

Future<bool> saveMqttStatus(String status) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("mqtt", status);
}

//ruok
Future<bool> getRuOkAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("ruOkStatus") ?? false;
}

Future<bool> saveRuOkAlertStatus(bool status) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("ruOkStatus", status);
}

Future<int> getRuOkAlertTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("ruOkTime")?? 8;
}

Future<bool> saveRuOkAlertTime(int time) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("ruOkTime", time);
}


//medication
Future<bool> getMediAlertStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("mediStatus") ?? false;
}

Future<bool> saveMediAlertStatus(bool status) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("mediStatus", status);
}

Future<int> getMediAlertTime() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("mediTime")?? 8;
}

Future<bool> saveMediAlertTime(int time) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("mediTime", time);
}
