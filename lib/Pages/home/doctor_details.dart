import 'package:assisted_healthcare/Objects/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:assisted_healthcare/Objects/body.dart';

class DetailsPage extends StatelessWidget {
  Doctor doctor;
  DetailsPage(Doctor doc) {
    doctor = doc;
  }

  @override
  Widget build(BuildContext context) {
    var imagePath =
        'https://image.shutterstock.com/shutterstock/photos/1095249842/display_1500/stock-vector-blank-avatar-photo-place-holder-1095249842.jpg';
    return Scaffold(
        body: Column(
      children: [
        Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                  child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imagePath),
                backgroundColor: Colors.transparent,
              )),
              height: 225,
              width: double.infinity,
            )),
        Center(
            child: new SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                        elevation: 5.0,
                        child: Center(
                            child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              BodySection('Name', doctor.name),
                              BodySection(
                                  'Specialties', doctor.specialties.join()),
                              BodySection('Location', doctor.location),
                            ],
                          ),
                        ))))))
      ],
    ));
  }
}
