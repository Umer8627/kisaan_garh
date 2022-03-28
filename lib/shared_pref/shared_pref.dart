import 'package:shared_preferences/shared_preferences.dart';

class KeepUserLogin {
  static saveRegistrationDetails({required String registration}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('registration', registration);
  }

  static saveEmailDetails({required String email}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', email);
  }

  static Future getEmailDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('email');
  }

  static Future getRegistrationDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('registration');
  }
}
