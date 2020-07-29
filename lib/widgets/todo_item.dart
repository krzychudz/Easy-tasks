import 'package:flutter/material.dart';

import '../repositories/todo_repository.dart' as TodoTaskRepository;
import 'todo_item_mange_modal.dart';

import '../widgets/delete_confirmation_dialog.dart' as DialogHelper;

class TodoItem extends StatelessWidget {
  final String todoTitle;
  final String todoId;
  final Color backgroundColor;

  TodoItem({
    this.todoId,
    this.todoTitle,
    this.backgroundColor,
  });

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
        return await DialogHelper.showDeleteConfirmationDialog(context);
      },
      onDismissed: (direction) => TodoTaskRepository.removeTodoTask(todoId),
      child: Card(
        color: backgroundColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                todoTitle,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                onPressed: () => showEditBottomSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
