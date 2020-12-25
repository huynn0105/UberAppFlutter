class Validators{
  static isValidEmail(String email){
    final regularExpression = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regularExpression.hasMatch(email);
  }
  static isValidPassword(String password) => password.length >= 3;

  static isValidPhone(String phone) => phone.length > 3;

  static isValidName(String name) => name.length > 3;
}