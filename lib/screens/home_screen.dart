import 'package:flutter/material.dart';

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
  final List<Widget> _bottomNavigationPages = [
    Center(child: Text('Page1'),),
    Center(child: Text('Page2'),),
  ];

  void _onBottomNavigationTapped(int index) {
    setState(() {
      _currentBottomNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavigationPages[_currentBottomNavigationIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onBottomNavigationTapped(index),
        currentIndex: _currentBottomNavigationIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text('Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            title: Text('Notes')
          )
        ],
      ),
    );
  }
}
