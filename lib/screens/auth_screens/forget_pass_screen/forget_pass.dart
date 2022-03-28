import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisaan_garh/blocs/forget_pass/forget_cubit.dart';
import 'package:kisaan_garh/helping_widgets/alert_box/alert_box.dart';
import 'package:kisaan_garh/helping_widgets/screen_navigation/screen_navigation.dart';

import '../../../constants/textfield_validation/textfield_validation.dart';
import '../../../helping_widgets/custom_textfield/custom_textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String errorMessage = "";
  CheckValidation _checkValidation = CheckValidation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<ForgetCubit, ForgetState>(
              listener: (context, state) {
                if (state is ForgetFailed) {
                  showAlertDialog(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                return Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 26),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo3.png",
                            height: 170,
                          ),
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
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<ForgetCubit>(context)
                                    .forgetPassword(_emailController.text);
                                BackToPrevious(context);
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
                                "Send",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
