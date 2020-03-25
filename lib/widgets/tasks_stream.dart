import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_to_do/model/task.dart';
import 'package:shared_to_do/utils/constants.dart';
import 'package:shared_to_do/widgets/task_tile.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('tasks').snapshots(),
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
          List<TaskTile> taskTiles = [];
          List<Task> tasks = [];

          firestoreTasks.forEach((firestoreTask) {
            Task task = Task(
              id: firestoreTask.data['id'],
              title: firestoreTask.data['title'],
              isDone: firestoreTask.data['isDone'],
              createdBy: firestoreTask.data['createdBy'],
              timestamp: firestoreTask.data['timestamp'],
            );
            tasks.add(Task(
                id: task.id,
                title: task.title,
                isDone: task.isDone,
                createdBy: task.createdBy,
                timestamp: task.timestamp));
          });

          if (tasks.isNotEmpty) {
            tasks.sort((a, b) => b.timestamp.compareTo(a.timestamp));
            tasks.forEach((task) {
              taskTiles.add(TaskTile(
                taskId: task.id,
                title: task.title,
                timestamp: task.timestamp,
                author: task.createdBy,
                isDone: task.isDone,
              ));
            });
          }

          return ListView(
            children: taskTiles,
          );
        });
  }
}
