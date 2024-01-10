// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';

import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/services/auth/auth_exceptions.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;
  late final TextEditingController _height;
  late final TextEditingController _weight;
  late final TextEditingController _age;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    _age = TextEditingController();
    _height = TextEditingController();
    _weight = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _age.dispose();
    _height.dispose();
    _username.dispose();
    _weight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add other controllers and fix the design.
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/welcome wallpaper.jpg'), // Path to your background image
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to MyFitWizz!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'To get started, please fill in the following form.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  // final userCredential =
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  // devtools.log("User Created: ${userCredential.user?.email}");

                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(
                    verifyEmailRoute,
                    // (route) => false means to remove everything and not to keep anything
                  );
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                    context,
                    "Weak Password my nigga!\nWeak just like yo mama!\nAt least 6 characters, my nigga.",
                  );
                } on EmailAlreadyInUseAuthException {
                  showErrorDialog(
                    context,
                    "Why you trynna steal someone else's email.\nThis aint the hood.\nEnter an email that belongs to you, my nigga!",
                  );
                } on InvalidEmailAuthException {
                  showErrorDialog(
                    context,
                    "My niggaaaa! You stupid!\nAn email must have @something.com.",
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    'Authentication Error',
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Button background color
                foregroundColor: Colors.black, // Button text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Let\'s Go!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  loginRoute,
                );
              },
              child: const Text(
                'Already registered? Login here!',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
