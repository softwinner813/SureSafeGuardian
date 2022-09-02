
import 'package:equatable/equatable.dart';
import 'package:guardian/data/model/login/login_response.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  LoginSuccess({required this.response});
}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed({required this.error});
}