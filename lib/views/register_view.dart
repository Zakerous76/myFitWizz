// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/services/auth/auth_exceptions.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_constants.dart';
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
  late final TextEditingController _gender;
  late final TextEditingController _age;
  late final FirebaseFirestore _db;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    _age = TextEditingController();
    _height = TextEditingController();
    _weight = TextEditingController();
    _gender = TextEditingController();

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
    _gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
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
                controller: _username,
                decoration: InputDecoration(
                  hintText: 'User Name',
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
                controller: _height,
                decoration: InputDecoration(
                  hintText: 'Height',
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
                controller: _weight,
                decoration: InputDecoration(
                  hintText: 'Weight',
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
                controller: _age,
                decoration: InputDecoration(
                  hintText: 'Age',
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
                controller: _gender,
                decoration: InputDecoration(
                  hintText: 'Gender',
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
                    await AuthService.firebase().createUser(
                      email: email,
                      password: password,
                    );
                    await AuthService.firebase().updateDisplayName(_username.text);
                    AuthService.firebase().sendEmailVerification();
                    Navigator.of(context).pushNamed(
                      verifyEmailRoute,
                      // (route) => false means to remove everything and not to keep anything
                    );
          
                    _db = FirebaseFirestore.instance;
                    try {
                      await _db.collection(usersCollectionName).doc(AuthService.firebase().currentUser!.id).set(
                      {
                        userNameFieldname: _username.text,
                        ageFieldName: _age.text,
                        heightFieldName: _height.text,
                        weightFieldName: _weight.text,
                        genderFieldName: _gender.text,
                      }
                    );
                    } catch (e) {
                      print(e.toString());
                    }
          
                  } on WeakPasswordAuthException {
                    await showErrorDialog(
                      context,
                      "Weak Password!\nAt least 6 characters.",
                    );
                  } on EmailAlreadyInUseAuthException {
                    showErrorDialog(
                      context,
                      "Email already in use!",
                    );
                  } on InvalidEmailAuthException {
                    showErrorDialog(
                      context,
                      "Incorrect Email Format",
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
      ),
    );
  }
}
