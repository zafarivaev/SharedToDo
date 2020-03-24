import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_to_do/screens/register_screen.dart';
import 'package:shared_to_do/screens/sign_in_screen.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/auth_action_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBoyZoneColor,
        title: Text('Shared To-Do'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AuthActionButton(
                width: getScreenWidth(context) * 0.8,
                height: 50,
                title: 'Sign In',
                backgroundColor: kC64ntscColor,
                onPressedHandler: () {
                  Navigator.pushNamed(context, SignInScreen.id);
                },
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AuthActionButton(
                width: getScreenWidth(context) * 0.8,
                height: 50,
                backgroundColor: kBeniukonBronzeColor,
                title: 'Register',
                onPressedHandler: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
