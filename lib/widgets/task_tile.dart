import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String author;

  TaskTile({this.title, this.author});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title),
      background: Container(
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        color: Colors.yellow[600],
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'created by $author',
        ),
        trailing: Checkbox(
          value: false,
          onChanged: (newValue) {},
        ),
      ),
    );
  }
}
