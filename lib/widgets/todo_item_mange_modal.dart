import 'package:easy_notes/widgets/picker/color_picker.dart';
import 'package:flutter/material.dart';

import '../repositories/todo_repository.dart' as TodoTaskRepository;
import '../widgets/button/circular_raised_button.dart';

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
  TextEditingController _timeController = TextEditingController();
  var _isEditMode = false;
  var _selectedColorARGB = Color.fromARGB(240, 71, 208, 238);

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
      _selectedColorARGB = Color.fromARGB(240, 71, 208, 238);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          color: Color.fromARGB(240, 255, 255, 255),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              _isEditMode ? "Edit your task" : "Add a new todo task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularInput(
              textEditingController: _todoNameController,
              hint: 'Set a name',
            ),
            SizedBox(
              height: 20,
            ),
            CircularInput(
              textEditingController: _timeController,
              hint: 'Set a time (min)',
              inputType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Pick a color",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
            CircularRaisedButton(
              label: _isEditMode ? "Edit" : "Save",
              backgroundColor: Color.fromARGB(255, 0, 255, 194),
              onPressed: _isEditMode ? _editTodoItem : _addTodoItem,
            ),
          ],
        ),
      ),
    );
  }
}

class CircularInput extends StatelessWidget {
  const CircularInput({
    Key key,
    @required TextEditingController textEditingController,
    @required this.hint,
    this.inputType = TextInputType.text,
  })  : _todoNameController = textEditingController,
        super(key: key);

  final TextEditingController _todoNameController;
  final String hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      ),
      child: TextField(
        keyboardType: inputType,
        textAlign: TextAlign.center,
        autofocus: true,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
        controller: _todoNameController,
      ),
    );
  }
}
