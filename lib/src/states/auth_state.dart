import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable{
  const AuthState();
  @override
  List<Object> get props => [];
}
class AuthStateInitial extends AuthState{}

class AuthStateSuccess extends AuthState{
  final User user;
  const AuthStateSuccess({this.user});
  @override
  List<Object> get props => [user];
}

class AuthStateFailure extends AuthState{}