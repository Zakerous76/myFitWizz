import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/routes.dart';

class SignInUpView extends StatelessWidget {
  const SignInUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/sign_in_up_image.png'), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 140), // Add horizontal padding if needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // TODO: Insert your sign-in logic
                Navigator.of(context).pushNamed(
                  loginRoute,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Button background color
                foregroundColor: Colors.black, // Button text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 20),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16), // Space between the buttons
            const Text(
              'Or,',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16), // Space between the text and the button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  registerRoute,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Button background color
                foregroundColor: Colors.black, // Button text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
