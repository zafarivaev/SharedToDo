import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color backgroundColor;
  final Function onPressedHandler;
  final bool isEnabled;

  AuthActionButton(
      {@required this.width,
      @required this.height,
      @required this.title,
      @required this.backgroundColor,
      @required this.onPressedHandler,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: backgroundColor,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: isEnabled ? onPressedHandler : null,
      ),
    );
  }
}
