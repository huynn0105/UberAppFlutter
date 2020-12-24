import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object> get props => [];
}
class LoginEventEmailChanged extends LoginEvent{
  final String email;
  const LoginEventEmailChanged({this.email});
  @override
  List<Object> get props => [email];
}
class LoginEventPasswordChanged extends LoginEvent{
  final String password;
  const LoginEventPasswordChanged({this.password});
  @override
  List<Object> get props => [password];
}

class LoginEventPressed extends LoginEvent{
  final String email;
  final String password;
  const LoginEventPressed({this.email,this.password});
  @override
  List<Object> get props => [email,password];
}