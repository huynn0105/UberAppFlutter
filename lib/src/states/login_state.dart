import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;

  LoginState(
      {@required this.isValidPassword,
      @required this.isValidEmail,
      @required this.isSubmitting,
      @required this.isFailure,
      @required this.isSuccess});

  factory LoginState.initial() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  factory LoginState.loading() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory LoginState.success() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }

  factory LoginState.failure() {
    return LoginState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }

  LoginState cloneWith({
    bool isValidEmail,
    bool isValidPassword,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure}) {
    return LoginState(
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  LoginState cloneAndUpdate({bool isValidEmail, bool isValidPassword}) {
    return cloneWith(
        isValidEmail: isValidEmail,
        isValidPassword: isValidPassword);
  }

  @override
  String toString() {
    return 'LoginState{isValidEmail: $isValidEmail,\n isValidPassword: $isValidPassword,\n isSubmitting: $isSubmitting,\n isSuccess: $isSuccess,\n isFailure: $isFailure}';
  }
}
