import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../global_variable/global_varialble.dart';
import '../../shared_pref/shared_pref.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

// Password
  Future login(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        KeepUserLogin.saveEmailDetails(email: email);
        emit(LoginSuccess(user: user));
        print("user Login Success");
      }
    } catch (e) {
      final errorLogin = e.toString();
      print("this is my e in login function ==>>>> $e");
      if (errorLogin.contains('invalid') && errorLogin.contains('does not')) {
        emit(LoginFailed(error: "Invalid Email Or Password"));
      } else if (errorLogin.contains('no user') &&
          errorLogin.contains("The user may have been deleted")) {
        emit(LoginFailed(error: "Invalid Email Address or Password"));
      } else if (errorLogin.contains('badly')) {
        emit(LoginFailed(error: "Invalid Email Address or Password"));
      }
    }
  }
}
