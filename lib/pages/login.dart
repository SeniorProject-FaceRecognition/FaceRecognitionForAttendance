import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/pages/reset_password.dart';
import 'package:senior_project/services/Authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance System',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Login to your account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 44,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Enter an email' : null,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'User Email',
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            TextFormField(
              validator: (value) =>
                  value!.length < 6 ? 'Enter a password 6+ chars long' : null,
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'User Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPassword(),
                ),
              ),
              child: const Text(
                "Don't remember your password?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 88,
            ),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () async {
                  var result = await auth.signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                  if (result == null) {
                    error = ' wrong email or password';
                    setState(() {});
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
