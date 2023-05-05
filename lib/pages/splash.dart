import 'package:flutter/material.dart';
import 'package:senior_project/models/lecturer.dart';
import 'package:senior_project/pages/login.dart';
import 'package:senior_project/pages/selectClass.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    var x = 1;
    if (x == 1) {
      return SelectClass();
    } else {
      return LoginPage();
    }
  }
}
