import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user {
    return _auth.currentUser;
  }

  Future signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      notifyListeners();
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
