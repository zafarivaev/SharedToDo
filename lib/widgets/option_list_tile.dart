import 'package:flutter/material.dart';
import 'package:shared_to_do/utils/constants.dart';

class OptionListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTapHandler;

  OptionListTile({this.iconData, this.title, this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 40,
        color: kDesireColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            color: kBlueHorizonColor,
            fontWeight: FontWeight.w700),
      ),
      onTap: onTapHandler,
    );
  }
}
