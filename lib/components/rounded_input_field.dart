import 'package:flutter/material.dart';
import 'package:vaccinemgmt/components/text_field_container.dart';
import 'package:vaccinemgmt/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.teal[700],
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
