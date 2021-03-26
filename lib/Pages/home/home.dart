//* Yhis is where the search ui and bar will go

import 'package:assisted_healthcare/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
// TODO: Display "Hello, firstName" in home
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
=======

import 'package:flutter/material.dart';
class _ExamplePageState extends State<ExamplePage> {
  // controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Example' );
}
void _getNames() async {
  final response = await dio.get('https://swapi.co/api/people');
  List tempList = new List();
  for (int i = 0; i < response.data['results'].length; i++) {
    tempList.add(response.data['results'][i]);
  }

  setState(() {
    names = tempList;
    filteredNames = names;
  });
}
void _searchPressed() {
  setState(() {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        controller: _filter,
        decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
        ),
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text('Search Example');
      filteredNames = names;
      _filter.clear();
    }
  });
}
ExamplePageState() {
  _filter.addListener(() {
    if (_filter.text.isEmpty) {
      setState(() {
        _searchText = "";
        filteredNames = names;
      });
    } else {
      setState(() {
        _searchText = _filter.text;
      });
    }
  });
}
Widget _buildList() {
  if (!(_searchText.isEmpty)) {
    List tempList = new List();
    for (int i = 0; i < filteredNames.length; i++) {
      if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
        tempList.add(filteredNames[i]);
      }
    }
    filteredNames = tempList;
  }
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
      return new ListTile(
        title: Text(filteredNames[index]['name']),
        onTap: () => print(filteredNames[index]['name']),
      );
    },
  );
>>>>>>> main
}  
  
class _ExamplePageState extends State<ExamplePage> {
  // controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Example' );
}
void _getNames() async {
  final response = await dio.get('https://swapi.co/api/people');
  List tempList = new List();
  for (int i = 0; i < response.data['results'].length; i++) {
    tempList.add(response.data['results'][i]);
  }

  setState(() {
    names = tempList;
    filteredNames = names;
  });
}
void _searchPressed() {
  setState(() {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        controller: _filter,
        decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
        ),
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text('Search Example');
      filteredNames = names;
      _filter.clear();
    }
  });
}
ExamplePageState() {
  _filter.addListener(() {
    if (_filter.text.isEmpty) {
      setState(() {
        _searchText = "";
        filteredNames = names;
      });
    } else {
      setState(() {
        _searchText = _filter.text;
      });
    }
  });
}
Widget _buildList() {
  if (!(_searchText.isEmpty)) {
    List tempList = new List();
    for (int i = 0; i < filteredNames.length; i++) {
      if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
        tempList.add(filteredNames[i]);
      }
    }
    filteredNames = tempList;
  }
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
      return new ListTile(
        title: Text(filteredNames[index]['name']),
        onTap: () => print(filteredNames[index]['name']),
      );
    },
  );
}
