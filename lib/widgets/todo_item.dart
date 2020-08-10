import 'package:flutter/material.dart';

import 'todo_item_mange_modal.dart';

import '../widgets/delete_confirmation_dialog.dart' as DialogHelper;
import '../repositories/todo_repository.dart' as TodoTaskRepository;

class TodoItem extends StatelessWidget {
  final String todoTitle;
  final String todoId;
  final Color backgroundColor;
  final bool isDone;

  TodoItem({this.todoId, this.todoTitle, this.backgroundColor, this.isDone});

  void showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) => MangeTodoItemModal(
        taskId: todoId,
        taskName: todoTitle,
        backgroundColor: backgroundColor,
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          !isDone
              ? "Are you sure you want to move this task to DONE section?"
              : "Do you want to mark this task as TODO?",
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              await setItemDoneState(!isDone);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text(
              "No",
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> setItemDoneState(bool isDone) async {
    TodoTaskRepository.updateTodoTask(
      {
        "id": todoId,
        "isDone": isDone,
      },
    );
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
        return await DialogHelper.showConfirmationDialog(context);
      },
      onDismissed: (direction) => TodoTaskRepository.removeTodoTask(todoId),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        color: backgroundColor,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                todoTitle,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      !isDone ? Icons.done : Icons.close,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () => showConfirmationDialog(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Theme.of(context).accentColor,
                    onPressed: () => showEditBottomSheet(context),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
