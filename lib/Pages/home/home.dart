import 'package:assisted_healthcare/DatabaseRouter.dart';
import 'package:assisted_healthcare/Objects/Doctor.dart';
import 'package:assisted_healthcare/Pages/home/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // when search is submitted, filter doctorList to just the doctors with the specified specialty, full name or location
  void onSubmitted(String value) {
    filteredDoctorList = [];
    List<Doctor> doctorList =
        DatabaseRouter().clinics.values.toList()[0].doctors;
    int length = doctorList.length;
    for (int i = 0; i < length; i++) {
      if (doctorList[i].specialties[0].toLowerCase() == value.toLowerCase() ||
          doctorList[i].name.toLowerCase() == value.toLowerCase() ||
          doctorList[i].location.toLowerCase() == value.toLowerCase()) {
        filteredDoctorList.add(doctorList[i]);
        print("Doctors length is " + length.toString());
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
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: searchBar.getSearchAction(context),
      actions: [
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
      backgroundColor: Colors.white,
      appBar: searchBar.build(context),
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
