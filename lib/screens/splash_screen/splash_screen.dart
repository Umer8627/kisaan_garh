import 'package:flutter/material.dart';
import 'package:kisaan_garh/screens/dashboard/dashbaord.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../helping_widgets/screen_navigation/screen_navigation.dart';
import '../../shared_pref/shared_pref.dart';
import '../auth_screens/login_screen/login_screen.dart';
import '../registration_screen/select_registration/select_registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? alreadyLoginEmail;
  String? alreadyRegister;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkForAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo3.png", height: 200),
            ],
          ),
        ],
      ),
    );
  }

  Future checkForAuth() async {
    print("me checkForAuth k andr aya ho");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    KeepUserLogin.getEmailDetails().then((value) {
      setState(() {
        print(
            "setState k andr email check krny aya jo mila wo ye raha =>>>>>>>>$value");
        alreadyLoginEmail = value;
      });
      if (alreadyLoginEmail == null) {
        print("me alreadyLoginEmail == null ki condition");
        changeScreenReplace(context, LoginScreen());
      } else if (prefs.getString("userType") == null) {
        print("me prefs.getString ki value check krny aya ho ");
        changeScreenReplace(
            context,
            SelectRegistrationScreen(
              docId: alreadyLoginEmail!,
            ));
      } else {
        print("i am userType");
        print("${prefs.getString("userType")}");
        changeScreenReplace(
            context,
            Dashboard(
              docId: alreadyLoginEmail!,
              userType: "${prefs.getString("userType")}",
            ));
      }
    });
  }
}




/*Future checkForAuth() async {
    print("me check auth k andr aya ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("mery nichy ha aik chota toka");
    print(prefs.getString('username'));
    print(prefs.getString('token'));

    if (prefs.getString('name') == null || prefs.getString('token') == null) {
      print(" me 1st if me ho me");
      Navigator.pushReplacementNamed(context, Login_Page);
    }
    if (prefs.getString('name') != null || prefs.getString('token') != null) {
      print(" me 2nd if me ho me");

      Navigator.pushReplacementNamed(context, HomePageScreen.routeName,
          arguments: ScreenArguments(
              token: prefs.getString('token'),
              userName: prefs.getString('username'),
              deviceId: prefs.getString('deviceKey')));
    }
  }*/ 