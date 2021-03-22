import 'package:assisted_healthcare/Pages/login/login.dart';
import 'package:assisted_healthcare/Pages/registration/register.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return AuthPage(toggleView: toggleView);
    } else {
      return RegisterForm(toggleView: toggleView);
    }
  }
}
