// ignore: unused_import
// ignore_for_file: use_build_context_synchronously

// import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
      ),
      body: Padding(
        padding: scaffoldPaddingVar,
        child: Column(
          children: [
            const Text(
              "We've sent you an email verification. Please open it to verify your account.\nIf you haven't received a verification email yet, press the button below.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w300, height: 1.5),
            ),
            const Text(
              "",
            ),
            // This option is disabled because we only want verified users to be able to use the app.
            // Since our database stores notes and users based on email, without verification, someone can use someone elses email and access that user's information.
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  mainDashboardRoute,
                  (route) => false,
                );
              },
              child: const Text(
                "I will verify later",
                style: TextStyle(
                  color: darkModeTextColorVar,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified == false) {
                  AuthService.firebase()
                      .sendEmailVerification(); // We have decided to this in the register_view automatically as well.
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    mainDashboardRoute,
                    (_) => false,
                  );
                }
              },
              child: const Text(
                "Send email verification again",
                style: TextStyle(
                  color: darkModeTextColorVar,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (_) => false,
                );
              },
              child: const Text(
                "I have verified the email (Restart)",
                style: TextStyle(
                  color: darkModeTextColorVar,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
