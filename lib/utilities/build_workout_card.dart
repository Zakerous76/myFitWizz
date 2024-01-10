import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/views/exercises_by_category.dart';
import 'package:myfitwizz/views/quickworkout_view.dart';

Widget buildWorkoutCard(
  String title,
  String imagePath,
  BuildContext context,
  bool isQuickWorkout,
) {
  return GestureDetector(
    onTap: () {
      // Navigate to respective workout page
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => isQuickWorkout
            ? QuickWorkoutView(
                title: title,
                imagePath: imagePath,
              )
            : ExercisesByCategoryView(
                category: title,
              ),
      ));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the radius as needed
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0)), // Top corners rounded
            child: Image.asset(
              imagePath,
              width: workoutCardContainerSizeVar,
              height: workoutCardContainerSizeVar,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.all(4.0), // Add some padding around the title
            child: Text(
              title,
              style: const TextStyle(
                color: lightModeTextColorVar,
                fontSize: workoutCardTextSizeVar,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
