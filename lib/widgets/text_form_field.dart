import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  const CustomTextFormField(
      {Key? key,
      required this.hintText,
      this.isPassword = false,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please ${hintText.replaceRange(0, 1, hintText[0].toLowerCase())}";
        }
        return null;
      },
      obscureText: isPassword,
      obscuringCharacter: "*",
      decoration: new InputDecoration(
          hintText: hintText,
          border: new OutlineInputBorder(),
          errorBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.red))),
    );
  }
}
