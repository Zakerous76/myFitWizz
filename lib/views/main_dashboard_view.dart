
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/paths.dart';
import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/utilities/bottom_nav_bar.dart';
import 'package:myfitwizz/utilities/build_workout_card.dart';

class MainDashboardView extends StatefulWidget {
  const MainDashboardView({super.key});
  

  @override
  State<MainDashboardView> createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  @override
  Widget build(BuildContext context) {
    var screenSizeVar = MediaQuery.of(context).size.width;
    final String username = FirebaseAuth.instance.currentUser!.displayName ?? "";
    return Scaffold(
      appBar: AppBar(
        title:  Text('Hello $username!'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(addExerciseViewRoute);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.red,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, profileRoute);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: scaffoldPaddingVar,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(buttonPaddingVar),
              ),
              const Text("This Button is not yet implemented"),
              ElevatedButton(
                onPressed: () {
                  // Navigate to My Workout
                },
                style: ButtonStyle(
                    fixedSize:
                        WidgetStatePropertyAll(Size(screenSizeVar, 10))),
                child: const Text('My Workout'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Quick Workouts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: appBarTitleFontSizeVar * .8,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildWorkoutCard('Jogging', joggingImgPath, context, true),
                    buildWorkoutCard('Plank', plankImaPath, context, true),
                    buildWorkoutCard(
                        'Deadhang', deadhangImgPath, context, true),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: appBarTitleFontSizeVar * .8,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildWorkoutCard(
                      'Bodybuilding',
                      bodybuildingImgPath,
                      context,
                      false,
                    ),
                    buildWorkoutCard(
                      'Powerlifting',
                      powerliftingImgPath,
                      context,
                      false,
                    ),
                    buildWorkoutCard(
                      'Bodyweight',
                      bodyweightImgPath,
                      context,
                      false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(buttonPaddingVar),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(thesaurusRoute);
                  },
                  style: ButtonStyle(
                      fixedSize:
                          WidgetStatePropertyAll(Size(screenSizeVar, 10))),
                  child: const Text('Thesaurus'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBarWidget(context),
    );
  }
}
