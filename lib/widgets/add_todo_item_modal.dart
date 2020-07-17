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
      "id": DateTime.now().toIso8601String(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Add a new todo task",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
          ),
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter a title',
            ),
            controller: _todoNameController,
          ),
          SizedBox(height: 20,),
          FlatButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryTextTheme.headline1.color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            child: Text("Add item"),
            onPressed: _addTodoItem,
          )
        ],
      ),
    );
  }
}
