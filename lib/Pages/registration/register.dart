import 'package:assisted_healthcare/Pages/login/login.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';

class InsuranceItem {
  int value;
  String name;
  InsuranceItem(this.value, this.name);
}

class RegisterForm extends StatefulWidget {
  final Function toggleView;
  RegisterForm({this.toggleView});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  List<InsuranceItem> _dropdownItems = [
    InsuranceItem(1, "First Value"),
    InsuranceItem(2, "Second Item"),
    InsuranceItem(3, "Third Item"),
    InsuranceItem(4, "Fourth Item")
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

  // text field state
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

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
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
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
        //Text("You select ${_selectedItem.name}"),
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
        onPressed: () {},
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
                  height: 35.0,
                ),
                insuranceSelector,
                SizedBox(
                  height: 35.0,
                ),
                logInButton,
                SizedBox(
                  height: 35.0,
                ),
                registerButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
