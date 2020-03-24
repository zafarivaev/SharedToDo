import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_to_do/screens/tasks_screen.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/auth_action_button.dart';
import 'package:shared_to_do/widgets/auth_card.dart';
import 'package:shared_to_do/widgets/auth_text_field.dart';
import 'package:shared_to_do/widgets/error_dialog.dart';

class RegisterScreen extends StatefulWidget {
  static const id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";
  bool isButtonEnabled = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBeniukonBronzeColor,
        title: Text('Register'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: EdgeInsets.only(top: getScreenHeight(context) * 0.15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: getScreenWidth(context) * 0.9,
                height: getScreenHeight(context) * 0.5,
                child: AuthCard(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      'Input your credentials',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: kBeniukonBronzeColor,
                      ),
                    ),
                    Spacer(),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kBeniukonBronzeColor),
                      child: AuthTextField(
                        keyboardType: TextInputType.emailAddress,
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                        hintText: 'example@email.com',
                        textColor: kBlueHorizonColor,
                        isPassword: false,
                        onChanged: (newValue) {
                          setState(() {
                            email = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kBeniukonBronzeColor),
                      child: AuthTextField(
                        keyboardType: TextInputType.text,
                        icon: Icon(Icons.vpn_key),
                        labelText: 'Password',
                        hintText: 'Password',
                        textColor: kBlueHorizonColor,
                        isPassword: true,
                        onChanged: (newValue) {
                          setState(() {
                            password = newValue;
                            isButtonEnabled = password.length >= 6;
                          });
                        },
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    AuthActionButton(
                      width: getScreenWidth(context) * 0.7,
                      height: 40,
                      title: 'Register',
                      backgroundColor: kBeniukonBronzeColor,
                      onPressedHandler: () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();

                          setState(() {
                            isLoading = false;
                            preferences.setBool('is_logged_in', true);
                          });

                          Navigator.pushReplacementNamed(
                              context, TasksScreen.id);
                        } catch (error) {
                          setState(() {
                            isLoading = false;
                          });

                          showDialog(
                            context: context,
                            builder: (_) => ErrorDialog(message: error.message),
                          );
                        }
                      },
                      isEnabled: isButtonEnabled,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
