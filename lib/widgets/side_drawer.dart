import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Easy tasks',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text("Tasks History"),
            onTap: () {
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
