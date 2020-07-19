import 'package:flutter/material.dart';

import '../screens/todo_list_screen.dart';

import '../widgets/todo_item_mange_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _currentBottomNavigationIndex = 0;
  String _appBarTitle = "Daily tasks";

  final List<Widget> _bottomNavigationPages = [
    TodoListScreen(),
    Center(
      child: Text('Page2'),
    ),
  ];

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _appBarTitle = _getAppBarTitle(index);
      _currentBottomNavigationIndex = index;
    });
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "Daily tasks";
      case 1:
        return "Your notes";
      default:
        return "";
    }
  }

  void _showBottomModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) => MangeTodoItemModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => _showBottomModalSheet(context),
          ),
        ],
      ),
      body: _bottomNavigationPages[_currentBottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onBottomNavigationTapped(index),
        currentIndex: _currentBottomNavigationIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text('Tasks'),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.note), title: Text('Notes'))
        ],
      ),
    );
  }
}
