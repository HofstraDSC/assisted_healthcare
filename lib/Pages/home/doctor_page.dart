import 'package:assisted_healthcare/Objects/DoctorOffice.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  Doctor doctor = null;
  DoctorPage(Doctor doc) {
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
              backgroundImage: NetworkImage(
                  'https://image.shutterstock.com/shutterstock/photos/1095249842/display_1500/stock-vector-blank-avatar-photo-place-holder-1095249842.jpg'),
              backgroundColor: Colors.transparent,
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
