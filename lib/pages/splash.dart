import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/pages/login.dart';
import 'package:senior_project/pages/select_class.dart';
import 'package:senior_project/services/Authentication.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    if (auth.user != null) {
      return const SelectClass();
    } else {
      return const LoginPage();
    }
  }
}
