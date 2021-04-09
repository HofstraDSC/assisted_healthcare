import 'package:assisted_healthcare/DatabaseRouter.dart';
import 'package:assisted_healthcare/Objects/Doctor.dart';
import 'package:assisted_healthcare/Pages/home/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assisted_healthcare/services/DataController.dart';
import 'package:get/get.dart';
import 'package:assisted_healthcare/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

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

  List<Doctor> filteredDoctorList = [];
  // when search is submitted, filter doctorList to just the doctors with the specified specialty
  void onSubmitted(String value) {
    filteredDoctorList = [];
    List<Doctor> doctorList =
        DatabaseRouter().clinics.values.toList()[0].doctors;
    int length = doctorList.length;
    for (int i = 0; i < length; i++) {
      if (doctorList[i].specialties[0] == value) {
        filteredDoctorList.add(doctorList[i]);
      }
    }
  }

  SearchBar searchBar; // declare searchBar
  // constructor:
  _SearchState() {
    searchController.addListener(filter);
    // create search bar:
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: onSubmitted,
        buildDefaultAppBar: buildAppBar);
  }

  List<String> apply(List<Doctor> param) {
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
      return filtered;
    } else {
      return null;
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

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: searchBar.getSearchAction(context),
      actions: [
        /*GetBuilder<DataController>(
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
        ),*/
        TextButton.icon(
          icon: Icon(Icons.person),
          label: Text('Logout'),
          onPressed: () async {
            await _auth.signOut();
          },
          style: TextButton.styleFrom(primary: Colors.black),
        ),
      ],
      backgroundColor: Colors.lightBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      // floatingActionButton:
      //     FloatingActionButton(child: Icon(Icons.clear), onPressed: () {}),
      backgroundColor: Colors.white,
      appBar: searchBar.build(context),

      /*TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Search Doctors...',
              hintStyle: TextStyle(color: Colors.black)),
          controller: searchController,
          // onChanged: () {},
        ), //textfield*/

      body: ListView.builder(
          itemCount: filteredDoctorList.length,
          itemBuilder: (BuildContext context, int index) => Card(
              elevation: 2.0,
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (ctxt) {
                      return DetailsPage(filteredDoctorList[index]);
                    }));
                  },
                  title: Text(filteredDoctorList[index].name.toString())))),
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
