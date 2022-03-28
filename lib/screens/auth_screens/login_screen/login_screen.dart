import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_cubit/login_cubit.dart';
import '../../../constants/textfield_validation/textfield_validation.dart';
import '../../../global_variable/global_varialble.dart';
import '../../../helping_widgets/custom_height_width/custom_height_width.dart';
import '../../../helping_widgets/custom_textfield/custom_textfield.dart';
import '../../../helping_widgets/screen_navigation/screen_navigation.dart';
import '../../registration_screen/select_registration/select_registration_screen.dart';
import '../forget_pass_screen/forget_pass.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  CheckValidation _checkValidation = CheckValidation();
  String errorMessage = "";
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              customHeightWidth(height: 50),
              Image.asset(
                "assets/images/logo3.png",
                height: 170,
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailed) {
                    errorMessage = state.error;
                  }
                  if (state is LoginSuccess) {
                    changeScreen(
                        context,
                        SelectRegistrationScreen(
                          docId: docId,
                        ));
                  }
                },
                builder: (context, state) {
                  return _loginform(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _loginform(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 26),
        child: Form(
          key: _formKey,
          child: Column(children: [
            // ignore: todo
            //  TODO?? =>> Email Fields;
            CustomTextField(
              hintText: "E-mail Address*",
              prefixIcon: Icons.email,
              controller: _emailController,
              error: errorMessage,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Input E-mail Address";
                }
                if (!_checkValidation.isEmail(value)) {
                  return "Please Enter Valid Email";
                }
              },
            ),
            customHeightWidth(height: 2),
            // ignore: todo
            //  TODO?? =>> Password Fields;
            CustomTextField(
              hintText: "Password*",
              prefixIcon: Icons.lock,
              controller: _passwordController,
              error: errorMessage,
              suffixIcon: Icons.visibility,
              suffixIcon2: Icons.visibility_off,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Input Password";
                }
                if (value.length < 8) {
                  return "Password length must be greater than 8";
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    changeScreen(context, ForgetPassword());
                  },
                  child: Text(
                    "Forget Password?",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            customHeightWidth(height: 10),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  docId = _emailController.text.trim();
                  BlocProvider.of<LoginCubit>(context).login(
                    docId,
                    _passwordController.text,
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            customHeightWidth(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Don't have an account",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {
                        changeScreen(context, SignUpScreen());
                      },
                      icon: Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                        size: 23,
                      )),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
