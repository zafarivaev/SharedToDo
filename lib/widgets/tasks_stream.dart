import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_to_do/model/task.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/task_tile.dart';

import 'error_dialog.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final Firestore _firestore = Firestore.instance;
  Stream<QuerySnapshot> tasksStream;

  List<TaskTile> taskTiles = [];
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    tasksStream = _firestore.collection('tasks').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: tasksStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'No tasks added yet',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kDesireColor),
                  ),
                )
              ],
            );
          }
          final firestoreTasks = snapshot.data.documents;

          tasks = firestoreTasks
              .map((firestoreTask) => Task(
                    id: firestoreTask.data['id'],
                    title: firestoreTask.data['title'],
                    isDone: firestoreTask.data['isDone'],
                    createdBy: firestoreTask.data['createdBy'],
                    timestamp: firestoreTask.data['timestamp'],
                  ))
              .toList();

          taskTiles = tasks
              .map((task) => TaskTile(
                    taskId: task.id,
                    title: task.title,
                    timestamp: task.timestamp,
                    author: task.createdBy,
                    isDone: task.isDone,
                    onTaskStatusChange: (taskId, isDone) async {
                      await _firestore
                          .collection('tasks')
                          .document(taskId)
                          .updateData({'isDone': isDone})
                          .then((_) {})
                          .catchError((error) {
                            showDialog(
                                context: context,
                                builder: (_) => ErrorDialog(
                                      message: error.toString(),
                                    ));
                          });
                    },
                    onTaskDeleteHandler: (taskId) async {
                      await _firestore
                          .collection('tasks')
                          .document(taskId)
                          .delete()
                          .then((_) {});
                    },
                  ))
              .toList();

          taskTiles.sort((a, b) => b.timestamp.compareTo(a.timestamp));

          return ListView.builder(
            itemCount: taskTiles.length,
            itemBuilder: (context, index) {
              return taskTiles[index];
            },
          );
        });
  }
}
