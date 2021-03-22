import 'package:assisted_healthcare/Pages/login/login.dart';
import 'package:assisted_healthcare/Pages/registration/authenicate.dart';
import 'package:assisted_healthcare/Pages/registration/register.dart';
import 'package:assisted_healthcare/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    print(user);

    // return RegisterForm screen if signed out, home screen if signed in
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
