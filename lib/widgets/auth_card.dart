import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final List<Widget> children;

  AuthCard({this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
