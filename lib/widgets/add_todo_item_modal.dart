import 'package:flutter/material.dart';

import '../repositories/todo_repository.dart' as TodoTaskRepository;

class AddTodoItemModal extends StatefulWidget {
  final String taskName;
  final String taskId;

  AddTodoItemModal({
    this.taskName = "",
    this.taskId = "",
  });

  @override
  _AddTodoItemModalState createState() => _AddTodoItemModalState();
}

class _AddTodoItemModalState extends State<AddTodoItemModal> {
  TextEditingController _todoNameController = TextEditingController();
  var _isEditMode = false;

  Future<void> _addTodoItem() async {
    await TodoTaskRepository.pushTodoTaskToFirestore({
      "id": DateTime.now().toString(),
      "name": _todoNameController.text,
    });

    Navigator.pop(context);
  }

  Future<void> _editTodoItem() async {
    await TodoTaskRepository.editTodoTask({
      "id": widget.taskId,
      "name": _todoNameController.text,
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.taskName.isNotEmpty && widget.taskId.isNotEmpty;
    if (_isEditMode) {
      _todoNameController.text = widget.taskName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _isEditMode ? "Edit your task" : "Add a new todo task",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter a title',
            ),
            controller: _todoNameController,
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryTextTheme.headline1.color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Text(_isEditMode ? "Edit" : "Save"),
            onPressed: _isEditMode ? _editTodoItem : _addTodoItem,
          )
        ],
      ),
    );
  }
}
