import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final String error;
  final Function(String)? validator;
  final Colors? color;
  final TextInputType? inputType;

  final Function? onTap;

  const CustomTextField(
      {Key? key,
      this.onTap,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.color,
      required this.controller,
      required this.error,
      this.inputType,
      this.suffixIcon2})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      validator: (value) => widget.validator!(value!),
      obscureText: isVisible,
      decoration: InputDecoration(
          hintText: widget.hintText,
          errorText: widget.error,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Colors.grey,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Icon(
              isVisible == false ? widget.suffixIcon : widget.suffixIcon2,
              color: Colors.grey,
            ),
          ),
          fillColor: Colors.blueGrey[50],
          filled: true,
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          contentPadding: EdgeInsets.only(left: 30, top: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blueGrey.shade50,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blueGrey.shade50,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blueGrey.shade50,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blueGrey.shade50,
            ),
          ),
          border: InputBorder.none),
    );
  }
}

/*
    
*/ 
