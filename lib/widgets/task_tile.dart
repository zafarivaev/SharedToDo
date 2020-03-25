import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_to_do/utils/constants.dart';

class TaskTile extends StatefulWidget {
  final String taskId;
  final String title;
  final bool isDone;
  final int timestamp;
  final String author;

  final Function(String taskId) onTaskDeleteHandler;
  final Function(String taskId, bool isDone) onTaskStatusChange;
  final Function(String taskId, String taskTitle) onTaskEditHandler;

  TaskTile(
      {this.taskId,
      this.title,
      this.isDone,
      this.timestamp,
      this.author,
      this.onTaskDeleteHandler,
      this.onTaskStatusChange,
      this.onTaskEditHandler});

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
          onChanged: (_) {
            setState(() {
              isDone = !isDone;
            });
            widget.onTaskStatusChange(widget.taskId, isDone);
          },
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.yellow[600],
          icon: Icons.edit,
          onTap: () => widget.onTaskEditHandler(widget.taskId, widget.title),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: kDesireColor,
          icon: Icons.delete,
          onTap: () => widget.onTaskDeleteHandler(widget.taskId),
        )
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          if (actionType == SlideActionType.secondary) {
            widget.onTaskDeleteHandler(widget.taskId);
          } else {
            widget.onTaskEditHandler(widget.taskId, widget.title);
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
