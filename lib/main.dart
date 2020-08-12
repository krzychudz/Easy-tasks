import 'package:flutter/material.dart';

import './screens/todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy tasks',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        fontFamily: 'Roboto'
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TodoListScreen(),
      },
    );
  }
}
