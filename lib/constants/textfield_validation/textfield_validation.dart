class CheckValidation {
  bool isEmail(String value) {
    String regexForEmail =
        (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    RegExp regExp = RegExp(regexForEmail);
    return regExp.hasMatch(value);
  }

  bool isUsername(String value) {
    String regexUsername =
        (r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$");
    RegExp regExp = RegExp(regexUsername);
    return regExp.hasMatch(value);
  }
}
