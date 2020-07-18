import 'package:flutter/material.dart';

import '../repositories/todo_repository.dart' as TodoTaskRepository;

class TodoItem extends StatelessWidget {
  final String todoTitle;
  final String todoId;

  TodoItem({this.todoId, this.todoTitle});

  Future<bool> showDeleteConfirmationDialog(BuildContext buildContext) async {
    return await showDialog(
        context: buildContext,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you wish to delete this item?"),
            actions: <Widget>[
              FlatButton(
                child: const Text('Yes'),
                textColor: Colors.red,
                onPressed: () => Navigator.of(buildContext).pop(true),
              ),
              FlatButton(
                child: const Text('No'),
                onPressed: () => Navigator.of(buildContext).pop(false),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: EdgeInsets.only(right: 16.0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (dismissDirection) async {
        return await showDeleteConfirmationDialog(context);
      },
      onDismissed: (direction) => TodoTaskRepository.removeTodoTask(todoId),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(todoTitle),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
