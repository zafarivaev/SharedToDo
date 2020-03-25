import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_to_do/screens/task_detail_screen.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/task_drawer.dart';
import 'package:shared_to_do/widgets/tasks_stream.dart';

class TasksScreen extends StatefulWidget {
  static const id = 'tasks_screen';

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  bool isLoading = false;
  String _userEmail = "";

  void getCurrentUser() async {
    try {
      _currentUser = await _auth.currentUser();
      setState(() {
        _userEmail = _currentUser.email;
      });
    } catch (error) {}
  }

  void didChooseEdit(String taskId, String taskTitle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TaskDetailScreen(
        isEditing: true,
        taskId: taskId,
        taskTitle: taskTitle,
        showLoadingIndicator: () {
          setState(() {
            isLoading = true;
          });
        },
        hideLoadingIndicator: () {
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        drawer: TasksDrawer(userEmail: _userEmail, auth: _auth),
        appBar: AppBar(
          backgroundColor: kDesireColor,
          title: Text('Shared Tasks'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: kDesireColor,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => TaskDetailScreen(
                showLoadingIndicator: () {
                  setState(() {
                    isLoading = true;
                  });
                },
                hideLoadingIndicator: () {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            );
          },
        ),
        body: TasksList(
          didChooseEdit: didChooseEdit,
        ),
      ),
    );
  }
}
