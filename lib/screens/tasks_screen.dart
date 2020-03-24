import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_to_do/screens/welcome_screen.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/option_list_tile.dart';

class TasksScreen extends StatefulWidget {
  static const id = 'tasks_screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  String _userEmail = "";

  void getCurrentUser() async {
    try {
      _currentUser = await _auth.currentUser();
      setState(() {
        _userEmail = _currentUser.email;
      });
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                _userEmail,
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
                await _auth.signOut();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool('is_logged_in', false);
                Navigator.pushNamedAndRemoveUntil(
                    context, WelcomeScreen.id, (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: kDesireColor,
        title: Text('Shared Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kDesireColor,
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => WelcomeScreen());
        },
      ),
    );
  }
}
