import 'package:assisted_healthcare/models/user.dart';
import 'package:assisted_healthcare/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create TheUser object based on User
  TheUser _theUserFromUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<TheUser> get user {
    return _auth.authStateChanges().map(_theUserFromUser);
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _theUserFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in email/passwd
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _theUserFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register email/passwd
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create new doc for user w uid
      await DatabaseService(uid: result.user.uid)
          .updateUserData('firstName', 'lastName', 'insurance');
      return _theUserFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
