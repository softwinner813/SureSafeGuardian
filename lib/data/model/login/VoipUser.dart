// To parse this JSON data, do
//
//     final voipUser = voipUserFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VoipUser voipUserFromMap(String str) => VoipUser.fromMap(json.decode(str));

String voipUserToMap(VoipUser data) => json.encode(data.toMap());

class VoipUser {
  VoipUser({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  int? id;
  String? name;
  String? username;
  String? password;


  factory VoipUser.fromMap(Map<String, dynamic> json) => VoipUser(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
  };

  VoipUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
    username = json['username']?.toString();
    password = json['password']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
