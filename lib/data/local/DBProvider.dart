import 'dart:async';
import 'dart:io';

import 'package:guardian/data/local/shared_pref.dart';
import 'package:guardian/data/model/login/VoipUser.dart';
import 'package:guardian/data/model/mqtt/MedicineReminder.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 8, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //"event": "ess",
      //   "status": "iamlife",
      //   "name": "Doris#Smith#T",
      //   "version": "v0.2.53",
      //   "number": "000",
      //   "ip": "192.168.0.0",
      //   "temperature": "35",
      //   "client": "B9BE",
      //   "volt": "255",
      //   "batt": "100",
      //   "flag": "255"
      //   "ess": "v1.0.2"
      //   "created_at" : ""
      await db.execute("CREATE TABLE Event ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "user_id TEXT,"
          "event TEXT,"
          "status TEXT,"
          "name TEXT,"
          "version TEXT,"
          "number TEXT,"
          "ip TEXT,"
          "temperature TEXT,"
          "client TEXT,"
          "volt TEXT,"
          "batt TEXT,"
          "flag TEXT,"
          "ess TEXT,"
          "is_notified INTEGER,"
          "date_created datetime default current_timestamp"
          ")");

      await db.execute("CREATE TABLE MedicineReminder ("
          "id INTEGER,"
          "title TEXT,"
          "time datetime,"
          "days TEXT,"
          "date_created datetime default current_timestamp"
          ")");

      await db.execute("CREATE TABLE Voips ("
          "id INTEGER,"
          "name TEXT,"
          "username TEXT,"
          "password TEXT,"
          "date_created datetime default current_timestamp"
          ")");


    }, onUpgrade: (Database db, int version, int latest) async {
      if(latest >= 5){
          await db.execute("ALTER TABLE Event ADD COLUMN user_id TEXT;");
      }else if(latest >= 7){
        await db.execute("ALTER TABLE Event ADD COLUMN is_notified INTEGER;");
      }
    });
  }

  newEventAdded(MqttEvent event) async {
    final db = await database;
    var table = await db?.rawQuery("SELECT MAX(id)+1 as id FROM Event");
    int? id = table!.first["id"] as int?;
    String userId = await getUserName();
    //"event": "ess",
    //   "status": "iamlife",
    //   "name": "Doris#Smith#T",
    //   "version": "v0.2.53",
    //   "number": "000",
    //   "ip": "192.168.0.0",
    //   "temperature": "35",
    //   "client": "B9BE",
    //   "volt": "255",
    //   "batt": "100",
    //   "flag": "255"
    //   "ess": "v1.0.2"
    //   "date_created" : ""
    var raw = await db?.rawInsert(
        "INSERT Into Event (user_id,event,status,name,version,number,ip,temperature,client,volt,batt,flag,ess,date_created)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          userId,
          event.event,
          event.status,
          event.name,
          event.version,
          event.number,
          event.ip,
          event.temperature,
          event.client,
          event.volt,
          event.batt,
          event.flag,
          event.ess,
          DateTime.now().toIso8601String()
        ]);
    print("new event added.. ${event.toString()}");
    return raw;
  }

  Future<List<MqttEvent>> getAllEvent() async {
    final db = await database;
    String userID = await getUserName();
    var res = await db?.query("Event",where: "user_id = ?",whereArgs: [userID]);
    List<MqttEvent> list =
        res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
    return list;
  }


  Future<MqttEvent?> getEvent(String eventType) async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.query(
        "Event",
        where: "event = ? and user_id = ?",
        whereArgs: [eventType,userID],
      );
      return res!.isNotEmpty ? MqttEvent.fromMap(res.last) : null;
    }catch(e){

    }
  }



  Future<MqttEvent?> getEventLat() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.query(
        "Event",
      where: "user_id = ?",whereArgs: [userID]);
      return res!.isNotEmpty ? MqttEvent.fromMap(res.last) : null;
    }catch(e){

    }
  }

  Future<dynamic?> getEventTodaysEventCount() async {
    String userID = await getUserName();
    try {
      final db = await database;
      DateTime now = DateTime.now();
      var res =  await db?.rawQuery(
        "select COUNT(id) from event where date_created LIKE '${now.year}-${now.month}-${now.day}%' and user_id == '$userID'",
      );
      return res?.asMap().values.first.values.first;
    }catch(e){

    }
  }

  Future<List<MqttEvent>?> getAllAst() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event  IN('ast') and user_id == '$userID'  Order by id DESC",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list;
    }catch(e){

    }
  }

  Future<MqttEvent?> getLastAst() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event  IN('ast') and user_id == '$userID'  Order by id DESC LIMIT 1",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }

  Future<List<MqttEvent>> getAllEventFilter(String eventType) async {
    final db = await database;
    String userID = await getUserName();
    var res =
        await db?.query("Event", where: "event = ? and user_id = ?", whereArgs: [eventType,userID]);
    List<MqttEvent> list =
        res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<MqttEvent>> getAllEventPir() async {
    final db = await database;
    String userID = await getUserName();
    var res = await db?.rawQuery(
      "select * from Event where event  IN('pir') and user_id == '$userID' Order by id DESC",
    );
    List<MqttEvent> list =
        res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
    return list;
  }

  Future<MqttEvent?> getLastPirActive() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event == 'pir' and status == '1' and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }

  Future<MqttEvent?> getUsername() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event == 'ess' or event == 'ast' and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }

  Future<MqttEvent?> getLastPirInActive() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event  IN('pir')  and status == 0 and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }

  Future<MqttEvent?> getLastPir() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event == 'iamlife' and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }

  updateEventNotifier(int id) async {
    final db = await database;
    var raw = await db?.rawUpdate(
        "UPDATE Event set is_notified = ?  where id = ?",
        [
          1,
          id,
        ]);
    return raw;
  }

  deleteAllEvent() async {
    String userID = await getUserName();
    final db = await database;
    db?.rawDelete("Delete from Event where user_id == '$userID'");
  }

  deleteEvent(int id) async {
    final db = await database;
    return db?.delete("Event", where: "id = ?", whereArgs: [id]);
  }

  Future<List<MqttEvent>?> getAllRuokEvents() async {
    try {
      final db = await database;
      String userID = await getUserName();

      var res1 = await db?.rawQuery(
        "select * from Event where event == 'ruok' and status == 'responded' and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> listLastResponsed =
      res1!.isNotEmpty ? res1.map((c) => MqttEvent.fromMap(c)).toList() : [];


      var res = await db?.rawQuery(
          "select * from Event where event == 'ruok' and user_id == '$userID' and id >= '${listLastResponsed.first.id}' Order by id DESC LIMIT 5"
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list;
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<MqttEvent>?> getAllMedicationEvents() async {
    try {
      final db = await database;
      String userID = await getUserName();


      var res1 = await db?.rawQuery(
        "select * from Event where event == 'medication' and status == 'responded' and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> listLastResponsed =
      res1!.isNotEmpty ? res1.map((c) => MqttEvent.fromMap(c)).toList() : [];

      var res = await db?.rawQuery(
          "select * from Event where event == 'medication' and user_id == '$userID' and user_id == '$userID' Order by id DESC LIMIT 5"
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list;
    }catch(e){
      print(e.toString());
    }
  }

  Future<MqttEvent?> getLastMedication() async {
    String userID = await getUserName();
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Event where event == 'medication' and user_id == '$userID' Order by id DESC LIMIT 1",
      );
      List<MqttEvent> list =
      res!.isNotEmpty ? res.map((c) => MqttEvent.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }


  //medicine table
  newMedicineReminderAdded(MedicineReminder medicineReminder) async {
    final db = await database;
    var table =
        await db?.rawQuery("SELECT MAX(id)+1 as id FROM MedicineReminder");
    int? id = table!.first["id"] as int?;
    var raw = await db?.rawInsert(
        "INSERT Into MedicineReminder (id,title,time,days,date_created)"
        " VALUES (?,?,?,?,?)",
        [
          id ?? 1,
          medicineReminder.title.toString(),
          medicineReminder.time?.toIso8601String(),
          medicineReminder.days.toString(),
          DateTime.now().toIso8601String()
        ]);
    return raw;
  }

  updateMedicineReminderAdded(MedicineReminder medicineReminder) async {
    final db = await database;
    var raw = await db?.rawUpdate(
        "UPDATE MedicineReminder set title = ? ,time = ?,days = ? ,date_created = ? where id = ?",
        [
          medicineReminder.title.toString(),
          medicineReminder.time?.toIso8601String(),
          medicineReminder.days.toString(),
          DateTime.now().toIso8601String(),
          medicineReminder.id,
        ]);
    return raw;
  }

  Future<List<MedicineReminder>> getAllMedicineReminder() async {
    final db = await database;
    var res = await db?.rawQuery(
      "select * from MedicineReminder ",
    );
    List<MedicineReminder> list = res!.isNotEmpty
        ? res.map((c) => MedicineReminder.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<int> getMedicationReminder(int id) async {
    final db = await database;
    var res = await db?.rawQuery(
      "select * from MedicineReminder where id == ? Order by id DESC LIMIT 1",[id]
    );
    List<MedicineReminder> list =
    res!.isNotEmpty ? res.map((c) => MedicineReminder.fromMap(c)).toList() : [];
    return list.length;
  }
  deleteAllMedicineReminder() async {
    final db = await database;
    db?.rawDelete("Delete from MedicineReminder");
  }

  deleteMedicineReminder(int id) async {
    final db = await database;
    return db?.delete("MedicineReminder", where: "id = ?", whereArgs: [id]);
  }


  //voip user

  newVoipUser(VoipUser voipUser) async {
    final db = await database;
    var table =
    await db?.rawQuery("SELECT MAX(id)+1 as id FROM Voips");
    int? id = table!.first["id"] as int?;
    var raw = await db?.rawInsert(
        "INSERT Into Voips (id,name,username,password,date_created)"
            " VALUES (?,?,?,?,?)",
        [
          id ?? 1,
          voipUser.name.toString(),
          voipUser.username?.toString(),
          voipUser.password.toString(),
          DateTime.now().toIso8601String()
        ]);
    return raw;
  }


  Future<VoipUser?> getVoIPUser(int id) async {
    try {
      final db = await database;
      var res = await db?.rawQuery(
        "select * from Voips where id == '$id' Order by id DESC LIMIT 1",
      );
      List<VoipUser> list =
      res!.isNotEmpty ? res.map((c) => VoipUser.fromMap(c)).toList() : [];
      return list.first;
    }catch(e){

    }
  }

  updateVoipUser(VoipUser voipUser) async {
    final db = await database;
    var raw = await db?.rawUpdate(
        "UPDATE Voips set name = ? ,username = ?,password = ? ,date_created = ? where id = ?",
        [
          voipUser.name.toString(),
          voipUser.username?.toString(),
          voipUser.password.toString(),
          DateTime.now().toIso8601String(),
          voipUser.id,
        ]);
    return raw;
  }

  Future<List<VoipUser>> getAllVoipUser() async {
    final db = await database;
    var res = await db?.rawQuery(
      "select * from Voips ",
    );
    List<VoipUser> list = res!.isNotEmpty
        ? res.map((c) => VoipUser.fromMap(c)).toList()
        : [];
    return list;
  }

  deleteAllVoipUsers() async {
    final db = await database;
    db?.rawDelete("Delete from Voips");
  }

  deleteVoipUser(int id) async {
    final db = await database;
    return db?.delete("Voips", where: "id = ?", whereArgs: [id]);
  }


  // await db.execute("CREATE TABLE Voips ("
//           "id INTEGER,"
//           "name TEXT,"
//           "username TEXT,"
//           "password TEXT,"
//           "date_created datetime default current_timestamp"
//           ")");
}
