import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisaan_garh/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:kisaan_garh/constants/textfield_validation/textfield_validation.dart';
import 'package:kisaan_garh/helping_widgets/alert_box/alert_box.dart';
import 'package:kisaan_garh/helping_widgets/custom_height_width/custom_height_width.dart';

import 'package:kisaan_garh/helping_widgets/custom_textfield/custom_textfield.dart';
import 'package:kisaan_garh/helping_widgets/screen_navigation/screen_navigation.dart';
import 'package:kisaan_garh/screens/auth_screens/login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
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
              customHeightWidth(height: 20),
              Image.asset(
                "assets/images/logo3.png",
                height: 170,
              ),
              BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpFailed) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      showAlertDialog(context, state.error);
                    });
                  }
                  if (state is SignUpSuccess) {
                    changeScreen(context, LoginScreen());
                  }
                },
                builder: (context, state) {
                  return _signUpForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _signUpForm() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // ignore: todo
            //  TODO?? =>> Username Fields;
            CustomTextField(
              hintText: "username*",
              prefixIcon: Icons.person,
              inputType: TextInputType.name,
              controller: _usernameController,
              error: errorMessage,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Input Username";
                }
                if (!_checkValidation.isUsername(value)) {
                  return "Please Enter Valid Username";
                }
              },
            ),
            customHeightWidth(height: 2),
            // ignore: todo
            //  TODO?? =>> Number Fields;
            CustomTextField(
              hintText: "Numbers*",
              inputType: TextInputType.number,
              prefixIcon: Icons.phone,
              controller: _phoneController,
              error: errorMessage,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Input Number";
                }
              },
            ),
            customHeightWidth(height: 2),
            // ignore: todo
            //  TODO?? =>> CNIC Fields;
            CustomTextField(
              hintText: "CNIC*",
              inputType: TextInputType.number,
              prefixIcon: Icons.contacts_outlined,
              controller: _cnicController,
              error: errorMessage,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please Input CNIC";
                }
              },
            ),
            customHeightWidth(height: 2),
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
            customHeightWidth(height: 10),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<SignUpCubit>(context).register(
                      cnic: _cnicController.text.trim(),
                      number: _phoneController.text.trim(),
                      name: _usernameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text);
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
                  "Create an account",
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
                        changeScreen(context, LoginScreen());
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
