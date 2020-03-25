import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_to_do/screens/welcome_screen.dart';
import 'package:shared_to_do/utils/constants.dart';

import 'option_list_tile.dart';

class TasksDrawer extends StatelessWidget {
  final String userEmail;
  final FirebaseAuth auth;

  TasksDrawer({this.userEmail, this.auth});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              userEmail,
              style: TextStyle(fontSize: 24, color: kBlueHorizonColor),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          OptionListTile(
            iconData: Icons.exit_to_app,
            title: 'Sign Out',
            onTapHandler: () async {
              await auth.signOut();
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool('is_logged_in', false);
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomeScreen.id, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
