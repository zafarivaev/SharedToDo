import 'package:flutter/material.dart';
import 'package:shared_to_do/utils/constants.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  ErrorDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(message),
            SizedBox(
              height: 30,
            ),
            Icon(
              Icons.error,
              color: kDesireColor,
              size: 100,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
