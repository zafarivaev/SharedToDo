import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final double borderRadius;
  final double elevation;
  final Color backgroundColor;
  final Function onPressedHandler;
  final bool isEnabled;

  AuthActionButton(
      {@required this.width,
      @required this.height,
      @required this.title,
      this.borderRadius = 20.0,
      this.elevation = 1,
      @required this.backgroundColor,
      @required this.onPressedHandler,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
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
