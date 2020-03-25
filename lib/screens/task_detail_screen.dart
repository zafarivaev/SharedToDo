import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_to_do/model/task.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/auth_action_button.dart';
import 'package:shared_to_do/widgets/error_dialog.dart';
import 'package:uuid/uuid.dart';

class TaskDetailScreen extends StatefulWidget {
  final Function showLoadingIndicator;
  final Function hideLoadingIndicator;

  TaskDetailScreen({this.showLoadingIndicator, this.hideLoadingIndicator});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  FirebaseUser currentUser;
  String title;
  int timestamp;
  bool isButtonEnabled = false;

  Firestore _firestore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void getCurrentUserEmail() async {
    currentUser = await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(context) * 0.25 +
          MediaQuery.of(context).viewInsets.bottom,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Theme(
              data: Theme.of(context)
                  .copyWith(primaryColor: kBeniukonBronzeColor),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'My brand new task',
                  labelText: 'Task title',
                ),
                style: TextStyle(fontSize: 20, color: kBlueHorizonColor),
                cursorColor: kBeniukonBronzeColor,
                onChanged: (newValue) {
                  setState(() {
                    title = newValue;
                    isButtonEnabled = title.length > 0;
                  });
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            AuthActionButton(
              width: getScreenWidth(context) * 0.5,
              height: 50,
              title: 'Add',
              borderRadius: 10,
              elevation: 2,
              backgroundColor: kBeniukonBronzeColor,
              isEnabled: isButtonEnabled,
              onPressedHandler: () async {
                Navigator.pop(context);
                widget.showLoadingIndicator();

                try {
                  int timestamp = DateTime.now().millisecondsSinceEpoch;
                  Task newTask = Task(
                      id: Uuid().v4(),
                      title: title,
                      isDone: false,
                      createdBy: currentUser.email,
                      timestamp: timestamp);

                  await _firestore
                      .collection('tasks')
                      .document(newTask.id)
                      .setData({
                    'id': newTask.id,
                    'title': newTask.title,
                    'isDone': newTask.isDone,
                    'createdBy': newTask.createdBy,
                    'timestamp': newTask.timestamp
                  });

                  widget.hideLoadingIndicator();
                } catch (error) {
                  widget.hideLoadingIndicator();
                  showDialog(
                    context: context,
                    builder: (_) => ErrorDialog(message: error.message),
                  );
                }
              },
            ),
            Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
