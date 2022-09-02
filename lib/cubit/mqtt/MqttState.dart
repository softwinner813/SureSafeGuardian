import 'package:equatable/equatable.dart';
import 'package:guardian/data/model/mqtt/mqtt_event.dart';

abstract class MqttState extends Equatable {
  const MqttState();

  @override
  List<Object> get props => [];
}

class MqttInitial extends MqttState {}

class MqttLoading extends MqttState {}

// class MqttDataUpdated extends MqttState {
//   final MqttEvent response;
//
//   MqttDataUpdated({required this.response});
// }
//
// class MqttStateEventEssIAmLife extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventEssIAmLife({required this.response});
// }
//
// class MqttStateEventFireware extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventFireware({required this.response});
// }
//
// class MqttStateEventHomeAway extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventHomeAway({required this.response});
// }
//
// class MqttStateEventDial extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventDial({required this.response});
// }
//
// class MqttStateEventMqtt extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventMqtt({required this.response});
// }
//
// class MqttStateEventTemperature extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventTemperature({required this.response});
// }
//
// class MqttStateEventEthernet extends MqttState {
//   final MqttEvent response;
//
//   MqttStateEventEthernet({required this.response});
// }
