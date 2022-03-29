import 'package:flutter/material.dart';
import 'package:kisaan_garh/global_variable/global_varialble.dart';
import 'package:kisaan_garh/helping_widgets/custom_height_width/custom_height_width.dart';
import 'package:kisaan_garh/helping_widgets/custom_textfield/custom_textfield.dart';
import 'package:kisaan_garh/helping_widgets/screen_navigation/screen_navigation.dart';
import 'package:kisaan_garh/models/farmer_model/farmer_model.dart' as model;
import 'package:kisaan_garh/screens/dashboard/dashbaord.dart';

import 'package:kisaan_garh/shared_pref/shared_pref.dart';

class FarmerRegistration extends StatefulWidget {
  const FarmerRegistration({Key? key, required this.docId}) : super(key: key);
  final String docId;
  @override
  State<FarmerRegistration> createState() => _FarmerRegistrationState();
}

class _FarmerRegistrationState extends State<FarmerRegistration> {
  final _formerAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                      hintText: "Address*",
                      controller: _formerAddress,
                      inputType: TextInputType.streetAddress,
                      prefixIcon: Icons.add_location,
                      error: errorMessage,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Input Address";
                        }
                      },
                    ),
                    customHeightWidth(height: 5),
                    GestureDetector(
                      onTap: () async {

                        if (_formKey.currentState!.validate()) {
                          model.FarmerModel _farmerModel = model.FarmerModel(
                              docId: widget.docId, address: _formerAddress.text,
                           type: "farmer",
                          );
                          await firebaseFirestore
                              .collection("farmer_registration")
                              .doc(widget.docId)
                              .set(_farmerModel.toJson());
                          KeepUserLogin.saveRegistrationDetails(
                              userType: "farmer");

                          changeScreenReplace(
                              context,
                              Dashboard(
                                docId: widget.docId,
                                userType: "farmer",
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
