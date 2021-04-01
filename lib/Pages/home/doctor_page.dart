import 'package:assisted_healthcare/Objects/DoctorOffice.dart';
import 'package:flutter/material.dart';

class Doctor_Page extends StatelessWidget {
  Doctor doctor = null;
  Doctor_Page(Doctor doc) {
    doctor = doc;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
                child: CircleAvatar(
              radius: 50,
            )),
            height: 225,
            width: double.infinity,
          )),
      Flexible(
          flex: 3,
          child: Column(
            children: [
              Text(
                doctor.name,
                textScaleFactor: 1.5,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                doctor.specialties.toString(),
                textScaleFactor: 1.5,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
              ),
              Text(
                doctor.location,
                textScaleFactor: 1.5,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ))
    ]));
  }
}
