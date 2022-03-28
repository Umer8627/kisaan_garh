import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      primaryColorDark: Colors.black,
      fontFamily: "Archivo",
      textTheme: textTheme());
}

TextTheme textTheme() {
  return TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 34,
        fontWeight: FontWeight.bold,
        // fontFamily: "Roboto",
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        // fontFamily: "Roboto",
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        // fontFamily: "Roboto",
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        // color: secondaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        // fontFamily: "Roboto",
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        // fontFamily: "Roboto",
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.normal,
        // fontFamily: "Roboto",
      ));
}
