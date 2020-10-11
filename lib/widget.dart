import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/Screen/edit_screen.dart';

class AppDrawer extends StatelessWidget {
  Firestore fireStore = Firestore.instance;

  getMyName() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('abc'),
            accountEmail: Text('abc@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/ktm.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.place,
            ),
            title: Text('Find'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.add,
            ),
            title: Text('Add Room'),
            onTap: () {
              Navigator.pushNamed(context, EditScreen.routName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.mode_edit,
            ),
            title: Text('Edit'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings_applications,
            ),
            title: Text('Manage Product'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
