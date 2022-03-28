import 'package:flutter/material.dart';

SizedBox customHeightWidth({double? height, double? width}) {
  return SizedBox(
    width: width ?? 0,
    height: height ?? 0,
  );
}
