import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_to_do/screens/register_screen.dart';
import 'package:shared_to_do/screens/sign_in_screen.dart';
import 'package:shared_to_do/screens/tasks_screen.dart';
import 'package:shared_to_do/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    final isLoggedIn = instance.getBool('is_logged_in') ?? false;
    runApp(MyApp(
      isLoggedIn: isLoggedIn,
    ));
  });
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? TasksScreen() : WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        TasksScreen.id: (context) => TasksScreen(),
      },
    );
  }
}
