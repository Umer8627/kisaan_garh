import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String? errorMessage) {
  Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("OK"));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Sorry!",
      style:
          Theme.of(context).textTheme.headline4!.copyWith(color: Colors.orange),
    ),
    content: Text(
      "$errorMessage",
      style: Theme.of(context).textTheme.headline4!,
    ),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
