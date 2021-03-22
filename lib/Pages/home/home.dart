//* Yhis is where the search ui and bar will go
import 'package:assisted_healthcare/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This can be deleted, just added for debugging
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(primary: Colors.black),
          )
        ],
      ),
    );
  }
}
