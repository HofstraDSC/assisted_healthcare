import 'package:assisted_healthcare/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String firstName, String lastName, String insurance) async {
    // links firebase user to firestore
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'insurance': insurance,
    });
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data()['firstName'],
      lastName: snapshot.data()['lastName'],
      insurance: snapshot.data()['insurance'],
    );
  }

  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
