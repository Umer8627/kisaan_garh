import 'package:flutter/material.dart';
import '../../../global_variable/global_varialble.dart';
import '../../../helping_widgets/custom_height_width/custom_height_width.dart';
import '../../../helping_widgets/screen_navigation/screen_navigation.dart';
import '../company_registration/company_registration_screen.dart';
import '../farmer_registration/former_registration.dart';

class SelectRegistrationScreen extends StatefulWidget {
  final String docId;
  const SelectRegistrationScreen({Key? key, required this.docId})
      : super(key: key);

  @override
  State<SelectRegistrationScreen> createState() =>
      _SelectRegistrationScreenState();
}

class _SelectRegistrationScreenState extends State<SelectRegistrationScreen> {
  String? name;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo3.png",
              height: 130,
            ),
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome!",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        customHeightWidth(width: 10),
                        Text(
                          name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    customHeightWidth(height: 10),
                    Text(
                      "Register Yourself Kindly",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    customHeightWidth(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeScreen(
                                context, CompanyRegister(docId: widget.docId));
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
                              "As a Company",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    customHeightWidth(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeScreen(
                                context,
                                FarmerRegistration(
                                  docId: widget.docId,
                                ));
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
                              "As a Farmer",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCurrentUser() async {
    var username =
        (await firebaseFirestore.collection("users").doc(widget.docId).get())
            .data()?["name"];
    setState(() {
      name = username;
    });
  }
}
