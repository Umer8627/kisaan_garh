import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/models/user_model/user_model.dart' as model;

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  // Password
  Future register({
    required String name,
    required String email,
    required String password,
    required String cnic,
    required String number,
  }) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        docId = email; //This is global Variable
        model.UserModel userModel = model.UserModel(
            id: docId,
            name: name,
            cnic: cnic,
            email: email,
            number: number,
            password: password);
        firebaseFirestore
            .collection("users")
            .doc(docId)
            .set(userModel.toJson());
        emit(SignUpSuccess(user: user));
        print("user is Added");
      }
    } catch (e) {
      var error = e.toString();
      if (error.contains('permission')) {
        emit(SignUpFailed(error: 'Email is Already Taken'));
      }
      if (error.contains('already') && error.contains('another')) {
        emit(SignUpFailed(error: "Email is Already Taken"));
      } else if (error.contains('badly')) {
        emit(SignUpFailed(error: "Enter a valid Email"));
      }
    }
  }
}
