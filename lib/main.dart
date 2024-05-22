// ignore_for_file: unused_local_variable

// ignore: unused_import
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/utilities/add_exercise_view.dart';
import 'package:myfitwizz/views/calculators/bmi_calculator_view.dart';
import 'package:myfitwizz/views/edit_personal_info_view.dart';
import 'package:myfitwizz/views/login_view.dart';
import 'package:myfitwizz/views/main_dashboard_view.dart';
import 'package:myfitwizz/views/onboarding/onboarding_view.dart';
import 'package:myfitwizz/views/personal_info_view.dart';
import 'package:myfitwizz/views/profile_view.dart';
import 'package:myfitwizz/views/register_view.dart';
import 'package:myfitwizz/views/onboarding/sign_in_up_view.dart';
import 'package:myfitwizz/views/calculators/calculators_view.dart';
import 'package:myfitwizz/views/thesaurus/thesaurus_view.dart';
import 'package:myfitwizz/views/verify_email_view.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized
  await AuthService.firebase().initialize();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // we are straight up returning the Material from here rather than returning a separate MyApp instance becasue this yields more performance
    title: 'MyFitWizz',
    theme: ThemeData(
      scaffoldBackgroundColor: backgroundColorVar,
      appBarTheme: const AppBarTheme(
        backgroundColor:
            appBarColorVar, // This sets the background color globally for all Scaffolds
        titleTextStyle: TextStyle(
          color: darkModeTextColorVar,
          fontWeight: FontWeight.bold,
          fontSize: appBarTitleFontSizeVar,
        ),
        iconTheme: IconThemeData(
          color:
              darkModeTextColorVar, // Here, you can set the color of the back arrow
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: darkModeTextColorVar), // default text style for body text
        bodyMedium: TextStyle(
          color: darkModeTextColorVar,
        ),
        bodySmall: TextStyle(
          color: darkModeTextColorVar,
        ), // default text style for body text with lower emphasis
        labelLarge: TextStyle(color: darkModeTextColorVar),
        labelMedium: TextStyle(color: darkModeTextColorVar),
        labelSmall: TextStyle(color: darkModeTextColorVar),
      ),
      dialogTheme: const DialogTheme(
          contentTextStyle: TextStyle(
        color: Colors.black,
      )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavigationBarColorVar,
      ),
      fontFamily: 'Poppins',
      listTileTheme: const ListTileThemeData(
        titleTextStyle: TextStyle(
          color: darkModeTextColorVar,
          fontWeight: FontWeight.bold,
          fontSize: appBarTitleFontSizeVar * .85,
        ),
        subtitleTextStyle: TextStyle(
          color: darkModeTextColorVar,
        ),
        leadingAndTrailingTextStyle: TextStyle(
          color: darkModeTextColorVar,
        ),
        contentPadding: EdgeInsets.all(
          scaffoldPaddingLateralVar,
        ),
      ),
    ),
    home: const HomePage(),
    routes: {
      // returns an instance of the loginview
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      mainRoute: (context) => const HomePage(),
      onboardingRoute: (context) => const OnboardingView(),
      signInUpRoute: (context) => const SignInUpView(),
      mainDashboardRoute: (context) => const MainDashboardView(),
      addExerciseViewRoute: (context) => const AddExerciseView(),
      thesaurusRoute: (context) => const ThesaurusView(),
      bmiCalculatorRoute: (context) => const BMICalculatorView(),
      calculatorsRoute: (context) => const CalculatorsView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
      profileRoute: (context) => const ProfileView(),
      editPersonalInfoRoute: (context) => EditPersonalInfoView(),
      personalInfoRoute: (context) => const PersonalInfoView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const MainDashboardView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const OnboardingView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
