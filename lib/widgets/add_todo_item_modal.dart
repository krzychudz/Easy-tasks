import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTodoItemModal extends StatefulWidget {
  @override
  _AddTodoItemModalState createState() => _AddTodoItemModalState();
}

class _AddTodoItemModalState extends State<AddTodoItemModal> {
  TextEditingController _todoNameController = TextEditingController();

  void _addTodoItem() async {
    await Firestore.instance.collection('todos').document(DateTime.now().toString()).setData({
      "name": _todoNameController.text,
      "date": DateTime.now().toIso8601String(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text("Add your todo stuff"),
          TextField(
            controller: _todoNameController,
          ),
          FlatButton(
            child: Text("Add item"),
            onPressed: _addTodoItem,
          )
        ],
      ),
    );
  }
}
