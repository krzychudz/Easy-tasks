import 'package:easy_notes/provider/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/todo_list_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TasksProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Easy tasks',
        theme: ThemeData(
            primaryColor: Colors.white,
            accentColor: Colors.black,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: Colors.transparent,
            fontFamily: 'Roboto'),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TodoListScreen(),
        },
      ),
    );
  }
}
