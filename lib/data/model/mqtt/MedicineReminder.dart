// To parse this JSON data, do
//
//     final medicineReminder = medicineReminderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MedicineReminder medicineReminderFromMap(String str) => MedicineReminder.fromMap(json.decode(str));

String medicineReminderToMap(MedicineReminder data) => json.encode(data.toMap());

class MedicineReminder {
  MedicineReminder({
    required this.id,
    required this.title,
    required this.time,
    required this.days,
    required this.daysList,
  });

  int? id;
  String? title;
  DateTime? time;
  String? days;
  List<String>? daysList;

  factory MedicineReminder.fromMap(Map<String, dynamic> json) => MedicineReminder(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    days: json["days"] == null ? null : json["days"],
    daysList: json["days_list"] == null ? null : List<String>.from(json["days_list"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "time": time == null ? null : time?.toIso8601String(),
    "days": days == null ? null : days,
    "days_list": daysList == null ? null : List<String>.from(daysList!.map((x) => x)),
  };
  MedicineReminder.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    time = json['time'];
    days = json['days']?.toString();
    if (json['days_list'] != null) {
      final v = json['days_list'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      daysList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['time'] = time;
    data['days'] = days;
    if (daysList != null) {
      final v = daysList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['days_list'] = arr0;
    }
    return data;
  }
}
