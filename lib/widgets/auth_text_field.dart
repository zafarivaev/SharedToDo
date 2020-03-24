import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final Icon icon;
  final String labelText;
  final String hintText;
  final Color textColor;
  final bool isPassword;
  final Function onChanged;

  AuthTextField(
      {this.keyboardType,
      this.icon,
      this.labelText,
      this.hintText,
      this.textColor,
      this.isPassword,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        hintText: hintText,
      ),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
      onChanged: onChanged,
    );
  }
}
