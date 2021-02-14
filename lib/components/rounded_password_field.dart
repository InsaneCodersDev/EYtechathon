import 'package:flutter/material.dart';
import 'package:vaccinemgmt/components/text_field_container.dart';
import 'package:vaccinemgmt/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final dynamic controller;
  const RoundedPasswordField({Key key, this.onChanged, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.teal[700],
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.teal[700],
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
