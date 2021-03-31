import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assisted_healthcare/services/DataController.dart';
import 'package:get/get.dart';
import 'package:assisted_healthcare/services/auth.dart';
import 'package:flutter/cupertino.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final AuthService _auth = AuthService();
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(snapshotData.docs[index].data()['image']),
            ),
            title: Text(
              snapshotData.docs[index].data()['title'],
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      );
    }

    var scaffold = Scaffold(
      // floatingActionButton:
      //     FloatingActionButton(child: Icon(Icons.clear), onPressed: () {}),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(primary: Colors.black),
          ),
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              var search_icon = IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    val.queryData(searchController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  });
              return search_icon;
            },
          )
        ],
        title: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.black)), //inputdeco
          controller: searchController,
        ), //textfield
        backgroundColor: Colors.white,
      ), //appbar
      body: isExecuted
          ? searchedData()
          : Container(
              child: Center(child: Text('Search Doctors')),
            ),
    );
    return scaffold; //scaffold
  }
}
