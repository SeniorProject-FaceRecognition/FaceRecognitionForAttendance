import 'package:flutter/material.dart';
import 'package:senior_project/services/authentication.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  void dialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text('Password reset link sent!'),
        );
      },
    );
  }

  final auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Reset your password !"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('Enter your email'),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              controller: _emailController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: const Color(0xFF0069FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () async {
              auth.resetPassword(
                _emailController.text.trim(),
              );
              dialog();
            },
            child: const Text(
              'Reset password',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
