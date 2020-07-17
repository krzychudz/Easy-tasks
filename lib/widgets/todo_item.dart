import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todoTitle;
  final String todoId;

  TodoItem({this.todoId, this.todoTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Text(todoTitle),
          Row(
          children: <Widget>[
          IconButton(icon: Icon(Icons.delete),
          onPressed: () {

           },),
          IconButton(icon: Icon(Icons.edit), 
          onPressed: () {

          },),
          ],),
        ],),
      )
    ,);
  }
}