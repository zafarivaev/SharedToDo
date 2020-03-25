import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_to_do/utils/constants.dart';

import 'error_dialog.dart';

class TaskTile extends StatefulWidget {
  final String taskId;
  final String title;
  final bool isDone;
  final int timestamp;
  final String author;

  TaskTile({this.taskId, this.title, this.isDone, this.timestamp, this.author});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isDone;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isDone = widget.isDone;
  }

  final Firestore _firestore = Firestore.instance;

  Future<bool> deleteTask() async {
    await _firestore
        .collection('tasks')
        .document(widget.taskId)
        .delete()
        .then((_) {
      return true;
    }).catchError((_) {
      return false;
    });

    return false;
  }

  void markTaskAsDone() {
    isDone = !isDone;
    setState(() {
      _firestore
          .collection('tasks')
          .document(widget.taskId)
          .updateData({'isDone': isDone})
          .then((_) {})
          .catchError((error) {
            showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                      message: error.toString(),
                    ));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      key: Key(widget.taskId),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'created by ${widget.author}',
        ),
        trailing: Checkbox(
          value: isDone,
          onChanged: (newValue) => markTaskAsDone(),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.yellow[600],
          icon: Icons.edit,
          onTap: () {},
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: kDesireColor,
          icon: Icons.delete,
          onTap: () => deleteTask(),
        )
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          if (actionType == SlideActionType.secondary) {
            deleteTask();
          } else {
            print('Should edit');
          }
        },
        onWillDismiss: (actionType) {
          if (actionType == SlideActionType.secondary) {
            return true;
          } else {
            return false;
          }
        },
      ),
    );
  }
}
