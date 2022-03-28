import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit() : super(ForgetInitial());
  Future forgetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      emit(ForgetSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgetFailed(errorMessage: e.message.toString()));
    } catch (e) {
      print("this is e in your forget password =>>>>>>$e");
    }
  }

  Future logout() async {
    await firebaseAuth.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
