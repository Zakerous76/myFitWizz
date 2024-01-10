// ignore_for_file: unused_local_variable

// ignore: unused_import
import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/utilities/add_exercise_view.dart';
import 'package:myfitwizz/views/calculators/bmi_calculator_view.dart';
import 'package:myfitwizz/views/thesaurus/exercise_view.dart';
import 'package:myfitwizz/views/login_view.dart';
import 'package:myfitwizz/views/main_dashboard_view.dart';
import 'package:myfitwizz/views/notes/create_update_notes_view.dart';
import 'package:myfitwizz/views/notes/notes_view.dart';
import 'package:myfitwizz/views/onboarding/onboarding_view.dart';
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
        // Add other TextStyles for different text types if needed
        labelLarge: TextStyle(color: darkModeTextColorVar), // default)
        labelMedium: TextStyle(color: darkModeTextColorVar), // default)
        labelSmall: TextStyle(color: darkModeTextColorVar), // default)
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavigationBarColorVar,
      ),
      // Set a default font family
      fontFamily: 'Poppins', // Replace with your font family

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
      notesRoute: (context) => const NotesView(),
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
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
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
                  return const NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const OnboardingView();
              }
            // // "If the user is non-null, take it. If the user is null then take false"
            // if (user?.emailVerified ?? false) {
            //   return const Text("Done");
            // } else {
            //   print("You are NOT verified, you need to verify my nigga!");
            //   // Navigator.of(context).push(MaterialPageRoute(          // Since we are returning a "Column" rather than a scaffold widget from the VerifyEmailView()
            //   //     builder: (context) => const VerifyEmailView()));
            // }
            // return const Text("Done");

            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
