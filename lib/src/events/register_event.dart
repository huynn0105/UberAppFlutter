import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable{

  const RegisterEvent();
  @override
  List<Object> get props => [];
}
class RegisterEventEmailChanged extends RegisterEvent{
  final String email;
  const RegisterEventEmailChanged({this.email});
  @override
  List<Object> get props => [email];
}
class RegisterEventPhoneChanged extends RegisterEvent{
  final String phone;
  const RegisterEventPhoneChanged({this.phone});
  @override
  List<Object> get props => [phone];
}
class RegisterEventNameChanged extends RegisterEvent{
  final String name;
  const RegisterEventNameChanged({this.name});
  @override
  List<Object> get props => [name];
}

class RegisterEventPasswordChanged extends RegisterEvent{
  final String password;
  const RegisterEventPasswordChanged({this.password});
  @override
  List<Object> get props => [password];
}
class RegisterEventPressed extends RegisterEvent{
  final String email;
  final String name;
  final String pass;
  final String phone;
  RegisterEventPressed({
    @required this.email,
    @required this.name,
    @required this.pass,
    @required this.phone
  });
@override
  List<Object> get props => [email,name,pass,phone];

}