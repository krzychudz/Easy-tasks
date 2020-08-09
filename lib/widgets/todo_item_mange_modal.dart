import 'package:easy_notes/widgets/picker/color_picker.dart';
import 'package:flutter/material.dart';

import '../repositories/todo_repository.dart' as TodoTaskRepository;

class MangeTodoItemModal extends StatefulWidget {
  final String taskName;
  final String taskId;
  final Color backgroundColor;

  MangeTodoItemModal({
    this.taskName = "",
    this.taskId = "",
    this.backgroundColor,
  });

  @override
  _MangeTodoItemModalState createState() => _MangeTodoItemModalState();
}

class _MangeTodoItemModalState extends State<MangeTodoItemModal> {
  TextEditingController _todoNameController = TextEditingController();
  var _isEditMode = false;
  var _selectedColorARGB = Color(0);

  Future<void> _addTodoItem() async {
    await TodoTaskRepository.pushTodoTaskToFirestore({
      "id": DateTime.now().toString(),
      "name": _todoNameController.text,
      "backgroundColor": [
        _selectedColorARGB.alpha,
        _selectedColorARGB.red,
        _selectedColorARGB.green,
        _selectedColorARGB.blue,
      ],
      "isDone": false,
    });

    Navigator.pop(context);
  }

  Future<void> _editTodoItem() async {
    var selectedColorToList = [
      _selectedColorARGB.alpha,
      _selectedColorARGB.red,
      _selectedColorARGB.green,
      _selectedColorARGB.blue
    ];
    await TodoTaskRepository.updateTodoTask({
      "id": widget.taskId,
      "name": _todoNameController.text,
      "backgroundColor": selectedColorToList,
    });

    Navigator.pop(context);
  }

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      child: ColorPicker(),
    ).then((pickedColor) => {
          if (pickedColor != null)
            {
              setState(() {
                _selectedColorARGB = Color.fromARGB(
                  pickedColor.alpha,
                  pickedColor.red,
                  pickedColor.green,
                  pickedColor.blue,
                );
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    print(widget.backgroundColor);
    _isEditMode = widget.taskName.isNotEmpty && widget.taskId.isNotEmpty;
    if (_isEditMode) {
      _todoNameController.text = widget.taskName;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.backgroundColor != null) {
      _selectedColorARGB = widget.backgroundColor;
    } else {
      _selectedColorARGB = Theme.of(context).primaryColor;
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
          Row(
            children: <Widget>[
              Text(
                "Pick a color",
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => _showColorPickerDialog(context),
                    child: CircleAvatar(
                      backgroundColor: _selectedColorARGB,
                    ),
                  ),
                ),
              ),
            ],
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
