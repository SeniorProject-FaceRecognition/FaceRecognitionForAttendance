import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/pages/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<FirebaseApp> _initializeFirebase() async {
      FirebaseApp firebaseApp = await Firebase.initializeApp();
      return firebaseApp;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
