import 'package:flutter/material.dart';
import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/helping_widgets/custom_height_width/custom_height_width.dart';
import 'package:kisaan_garh/helping_widgets/custom_textfield/custom_textfield.dart';
import 'package:kisaan_garh/helping_widgets/screen_navigation/screen_navigation.dart';
import 'package:kisaan_garh/models/company_model/company_model.dart' as model;
import 'package:kisaan_garh/screens/dashboard/dashbaord.dart';

import 'package:kisaan_garh/shared_pref/shared_pref.dart';

class CompanyRegister extends StatefulWidget {
  final String docId;
  const CompanyRegister({Key? key, required this.docId}) : super(key: key);

  @override
  State<CompanyRegister> createState() => _CompanyRegisterState();
}

class _CompanyRegisterState extends State<CompanyRegister> {
  final _formKey = GlobalKey<FormState>();
  final _companyName = TextEditingController();
  final _companyAddress = TextEditingController();

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
            elevation: 7,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo3.png",
                      height: 130,
                    ),
                    CustomTextField(
                      hintText: "Company Name*",
                      controller: _companyName,
                      inputType: TextInputType.streetAddress,
                      prefixIcon: Icons.add_moderator_rounded,
                      error: errorMessage,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Input Company Name";
                        }
                      },
                    ),
                    customHeightWidth(height: 5),
                    CustomTextField(
                      hintText: "Company Addresss*",
                      controller: _companyAddress,
                      inputType: TextInputType.streetAddress,
                      prefixIcon: Icons.add_location,
                      error: errorMessage,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Input Company Address";
                        }
                      },
                    ),
                    customHeightWidth(height: 20),
                    GestureDetector(
                      onTap: () async {

                        if (_formKey.currentState!.validate()) {
                          model.CompanyModel _companyModel = model.CompanyModel(
                              docId: widget.docId,
                              name: _companyName.text,
                              address: _companyAddress.text,
                              type: "company",
                          );
                          await firebaseFirestore
                              .collection("companies_register")
                              .doc(widget.docId)
                              .set(_companyModel.toJson());
                          KeepUserLogin.saveRegistrationDetails(
                              userType: "company");
                          changeScreenReplace(
                              context,
                              Dashboard(
                                docId: widget.docId,
                                userType: "company",
                              ));
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
                          "Register",
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
          ),
        ]),
      ),
    );
  }
}
