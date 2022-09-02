import 'package:meta/meta.dart';
import 'dart:convert';

MqttEvent clientFromJson(String str) {
  final jsonData = json.decode(str);
  return MqttEvent.fromMap(jsonData);
}

String clientToJson(MqttEvent data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
// To parse this JSON data, do
//
//     final mqttEvent = mqttEventFromMap(jsonString);


MqttEvent mqttEventFromMap(String str) => MqttEvent.fromMap(json.decode(str));

String mqttEventToMap(MqttEvent data) => json.encode(data.toMap());

class MqttEvent {
  /*
{
  "event": "ess",
  "status": "iamlife",
  "name": "Doris#Smith#T",
  "version": "v0.2.53",
  "number": "000",
  "ip": "192.168.0.0",
  "temperature": "35",
  "client": "B9BE",
  "volt": "255",
  "batt": "100",
  "flag": "255",
  "ess":"V0.2.69",
  "date_created":"2021-11-17 08:09:25"
}
*/
  dynamic? id;
  String? event;
  String? status;
  String? name;
  String? version;
  String? number;
  String? ip;
  String? temperature;
  String? client;
  String? volt;
  String? batt;
  String? flag;
  String? ess;
  int? isNotified;
  DateTime? dateCreated;

  MqttEvent({
    this.event,
    this.status,
    this.name,
    this.version,
    this.number,
    this.ip,
    this.temperature,
    this.client,
    this.volt,
    this.batt,
    this.flag,
    this.ess,
    this.dateCreated,
    this.isNotified,
    this.id
  });

  factory MqttEvent.fromMap(Map<String, dynamic> json) => MqttEvent(
    id: json["id"] == null ? null : json["id"],
    event: json["event"] == null ? null : json["event"],
    status: json["status"] == null ? null : json["status"],
    name: json["name"] == null ? null : json["name"],
    version: json["version"] == null ? null : json["version"],
    number: json["number"] == null ? null : json["number"],
    ip: json["ip"] == null ? null : json["ip"],
    temperature: json["temperature"] == null ? null : json["temperature"],
    client: json["client"] == null ? null : json["client"],
    volt: json["volt"] == null ? null : json["volt"],
    batt: json["batt"] == null ? null : json["batt"],
    flag: json["flag"] == null ? null : json["flag"],
    ess: json["ess"] == null ? null : json["ess"],
    isNotified: json["is_notified"] == null ? null : json["is_notified"],
    dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "event": event == null ? null : event,
    "status": status == null ? null : status,
    "name": name == null ? null : name,
    "version": version == null ? null : version,
    "number": number == null ? null : number,
    "ip": ip == null ? null : ip,
    "temperature": temperature == null ? null : temperature,
    "client": client == null ? null : client,
    "volt": volt == null ? null : volt,
    "batt": batt == null ? null : batt,
    "flag": flag == null ? null : flag,
    "ess": ess == null ? null : ess,
    "is_notified": isNotified == null ? null : isNotified,
    "date_created": dateCreated == null ? null : dateCreated?.toIso8601String(),
  };

  MqttEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    event = json['event']?.toString();
    status = json['status']?.toString();
    name = json['name']?.toString();
    version = json['version']?.toString();
    number = json['number']?.toString();
    ip = json['ip']?.toString();
    temperature = json['temperature']?.toString();
    client = json['client']?.toString();
    volt = json['volt']?.toString();
    batt = json['batt']?.toString();
    flag = json['flag']?.toString();
    ess = json['ess']?.toString();
    isNotified = json['is_notified'];
    dateCreated = json['date_created'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['event'] = event;
    data['status'] = status;
    data['name'] = name;
    data['version'] = version;
    data['number'] = number;
    data['ip'] = ip;
    data['temperature'] = temperature;
    data['client'] = client;
    data['volt'] = volt;
    data['batt'] = batt;
    data['flag'] = flag;
    data['ess'] = ess;
    data['ess'] = ess;
    data['is_notified'] = isNotified;
    data['date_created'] = ess;
    return data;
  }
}
