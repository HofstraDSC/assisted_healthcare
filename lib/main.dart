import 'package:assisted_healthcare/Pages/wrapper.dart';
import 'package:assisted_healthcare/models/user.dart';
import 'package:assisted_healthcare/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/DatabaseRouter.dart';

void main() async {
  runApp(MyApp());
  await Firebase.initializeApp();
  new DatabaseRouter().init();
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize Firebase in Flutter
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return StreamProvider<TheUser>.value(
              // access data from TheUser
              value: AuthService().user,
              initialData: null,
              child: MaterialApp(home: Wrapper()) // Show app
              );
        });
  }
}
