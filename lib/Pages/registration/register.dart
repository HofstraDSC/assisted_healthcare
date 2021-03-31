import 'package:flutter/material.dart';

import 'package:assisted_healthcare/Pages/login/login.dart';
import 'package:assisted_healthcare/models/user.dart';
import 'package:assisted_healthcare/services/database.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';

class InsuranceItem {
  int value;
  String name;
  InsuranceItem(this.value, this.name);
}

class RegisterForm extends StatefulWidget {
  final Function toggleView;
  RegisterForm({Key key, this.title, this.toggleView}) : super(key: key);
  final String title;

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final AuthService _auth = AuthService();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  List<InsuranceItem> _dropdownItems = [
    InsuranceItem(1, "Aetna"),
    InsuranceItem(2, "Beacon Health"),
    InsuranceItem(3, "Blue Cross Blue Shield Excellus"),
    InsuranceItem(4, "CHAMPVA"),
    InsuranceItem(5, "CIGNA"),
    InsuranceItem(6, "CDPHP"),
    InsuranceItem(7, "Department of Labor (Federal Workers’ Comp)"),
    InsuranceItem(8, "Empire Plan"),
    InsuranceItem(9, "Fidelis"),
    InsuranceItem(10, "First Health Network "),
    InsuranceItem(11, "GHI / Emblem PPO"),
    InsuranceItem(12, "Integrated Health Plan"),
    InsuranceItem(13, "Lifetime Benefit Solutions"),
    InsuranceItem(14, "Magna Care"),
    InsuranceItem(15, "Martin’s Point US Family Health Plan"),
    InsuranceItem(16, "Medicare"),
    InsuranceItem(17, "Medicaid"),
    InsuranceItem(18, "Meritain Health"),
    InsuranceItem(19, "MVP"),
    InsuranceItem(20, "No Fault"),
    InsuranceItem(21, "Preferred Healthcare Systems (PHCS)"),
    InsuranceItem(22, "Railroad Medicare"),
    InsuranceItem(23, "Unified IPA"),
    InsuranceItem(24, "United Health Care"),
    InsuranceItem(25, "Univera"),
    InsuranceItem(26, "Workers’ Compensation"),
  ];

  List<DropdownMenuItem<InsuranceItem>> _dropdownMenuItems;
  InsuranceItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<InsuranceItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<InsuranceItem>> items = [];
    for (InsuranceItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  String firstName = '';
  String lastName = '';
  String insurance = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onChanged: (val) {
        setState(() => firstName = val);
      },
    );
    final lastNameField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Last Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onChanged: (val) {
        setState(() => lastName = val);
      },
    );
    final emailField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onChanged: (val) {
        setState(() => email = val);
      },
    );
    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onChanged: (val) {
        setState(() => password = val);
      },
    );
    final insuranceSelector = Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 30.0, right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  isExpanded: true,
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  }),
            ),
          ),
        ),
      ],
    );
    // takes you to login page
    final logInButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          widget.toggleView();
        },
        child: Text("Log in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          dynamic result =
              await _auth.registerWithEmailAndPassword(email, password);
          if (result == null) {
            setState(() => error = 'Please supply valid email');
          }
          insurance = _selectedItem.name;
          await DatabaseService(uid: result.uid)
              .updateUserData(firstName, lastName, insurance);
        },
        child: Text("Register",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 25.0),
                firstNameField,
                SizedBox(height: 25.0),
                lastNameField,
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 35.0,
                ),
                insuranceSelector,
                SizedBox(
                  height: 35.0,
                ),
                registerButton,
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
