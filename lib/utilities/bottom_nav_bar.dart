import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/routes.dart';

Widget bottomNavigationBarWidget(BuildContext context) {
  return BottomNavigationBar(
    fixedColor: buttonColorVar,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: appBarColorVar),
      BottomNavigationBarItem(
        icon: Icon(Icons.calculate),
        label: 'Calculator',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.fitness_center),
        label: 'Skill',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    onTap: (index) {
      // Handle navigation to different pages based on the index
      switch (index) {
        case 0:
          Navigator.of(context).pushNamedAndRemoveUntil(
            mainDashboardRoute,
            (_) => false,
          );
          break;
        case 1:
          Navigator.of(context).pushNamed(
            calculatorsRoute,
          );
          break;
        case 2:
          Navigator.of(context).pushNamed(
            bmiCalculatorRoute,
          );
          break;
        case 3:
          Navigator.pushNamed(context, profileRoute);
          break;
      }
    },
  );
}
