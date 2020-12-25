import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidPhone;
  final bool isValidName;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isValid => isValidPassword && isValidEmail && isValidName && isValidPhone;

  const RegisterState({
    @required this.isValidEmail,
    @required this.isValidPassword,
    @required this.isValidPhone,
    @required this.isValidName,
    @required this.isSuccess,
    @required this.isSubmitting,
    @required this.isFailure});

  factory RegisterState.initial(){
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidPhone: true,
        isValidName: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false
    );
  }

  factory RegisterState.loading(){
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidPhone: true,
        isValidName: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false
    );
  }

  factory RegisterState.failure(){
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidPhone: true,
        isValidName: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true
    );
  }

  factory RegisterState.success(){
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidPhone: true,
        isValidName: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false
    );
  }


  RegisterState copyWith({
    bool isValidName,
    bool isValidPhone,
    bool isValidEmail,
    bool isValidPassword,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure}) {
    return RegisterState(
        isValidName: isValidName ?? this.isValidName,
        isValidPhone: isValidPhone ?? this.isValidPhone,
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  RegisterState cloneAndUpdate({
    bool isValidName,
    bool isValidPhone,
    bool isValidEmail,
    bool isValidPassword}) {
    return copyWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword,
      isValidName: isValidName,
      isValidPhone: isValidPhone,
    );
  }


  @override
  String toString() {
    return '''RegisterState {
      isValidEmail: $isValidEmail,
      isValidPassword: $isValidPassword,      
      isValidName: $isValidName,      
      isValidPhone: $isValidPhone,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}