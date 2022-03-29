import 'package:shared_preferences/shared_preferences.dart';

class KeepUserLogin {
  static saveRegistrationDetails({required String userType}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userType', userType);
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
