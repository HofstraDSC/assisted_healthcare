import 'package:assisted_healthcare/DatabaseRouter.dart';
import 'package:assisted_healthcare/Objects/Doctor.dart';
import 'package:assisted_healthcare/Pages/home/doctor_details.dart';
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

//todo: Create constructor
class _SearchState extends State<Search> {
  final AuthService _auth = AuthService();
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;

  _SearchState() {
    searchController.addListener(filter);
  }

  List<String> apply(List<Doctor> param) {
    if (searchController.text != "") {
      int count = DatabaseRouter().clinics.values.toList()[0].doctors.length;
      for (int i = 0; i < count; i++) {
        List<String> filtered;
        var t = DatabaseRouter()
            .clinics
            .values
            .toList()[0]
            .doctors[i]
            .name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
        print(t);
        if (t) {
          filtered
              .add(DatabaseRouter().clinics.values.toList()[0].doctors[i].name);
        }
        return filtered;
      }
      // for (int i = 0;
      //     i < DatabaseRouter().clinics.values.toList()[0].doctors.length;
      //     i++) {
      //   var filteredDoctors = print(
      //       .where((doc) => doc.doctors[i].name
      //           .toString()
      //           .toLowerCase()
      //           .contains(searchController.text.toLowerCase())));
      // }
    }
  }

  void filter() {
    if (searchController.text != "") {
      int count = DatabaseRouter().clinics.values.toList()[0].doctors.length;
      List<String> filtered;
      for (int i = 0; i < count; i++) {
        var t = DatabaseRouter()
            .clinics
            .values
            .toList()[0]
            .doctors[i]
            .name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
        print(t);
        if (t) {
          filtered
              .add(DatabaseRouter().clinics.values.toList()[0].doctors[i].name);
        }
      }
      // for (int i = 0;
      //     i < DatabaseRouter().clinics.values.toList()[0].doctors.length;
      //     i++) {
      //   var filteredDoctors = print(
      //       .where((doc) => doc.doctors[i].name
      //           .toString()
      //           .toLowerCase()
      //           .contains(searchController.text.toLowerCase())));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              var searchIcon = IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    val.queryData(searchController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  });
              return searchIcon;
            },
          )
        ],
        title: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Search Doctors...',
              hintStyle: TextStyle(color: Colors.black)),
          controller: searchController,
          // onChanged: () {},
        ), //textfield
        backgroundColor: Colors.lightBlue,
      ), //appbar
      body: ListView.builder(
          itemCount: DatabaseRouter().clinics.values.toList()[0].doctors.length,
          itemBuilder: (BuildContext context, int index) => Card(
              elevation: 2.0,
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (ctxt) {
                      return DetailsPage(DatabaseRouter()
                          .clinics
                          .values
                          .toList()[0]
                          .doctors[index]);
                    }));
                  },
                  title: Text(DatabaseRouter()
                      .clinics
                      .values
                      .toList()[0]
                      .doctors[index]
                      .name
                      .toString())))
          //? searchedData()

          ),
      //*If you want access the database, new DatabaseRouter().clinics;
      //* for a list you can use new DatabaseRouter().clinics.values;
    );
    return scaffold; //scaffold
  }

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
}
