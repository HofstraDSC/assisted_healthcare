import 'package:assisted_healthcare/Objects/Doctor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRouter {
  static final DatabaseRouter _db = DatabaseRouter._internal();
  Map<String, DoctorList> clinics;

  factory DatabaseRouter() {
    return _db;
  }

  DatabaseRouter._internal();

  ///
  ///Initializes the DatabaseRouting singleton
  ///
  void init() async {
    await loadOffices();
  }

  ///
  /// Pulls all Doctors Offices
  ///
  loadOffices() async {
    //textbooks = new List();
    clinics = new Map<String, DoctorList>();
    CollectionReference ref = FirebaseFirestore.instance.collection('doctors');
    DocumentSnapshot document = await ref.doc("Doctors").get();

    clinics[document.id] = new DoctorList(document['doctors']);
    print(clinics.toString());
  }
}
