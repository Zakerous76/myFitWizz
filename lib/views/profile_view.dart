// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/enums/menu_action.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/utilities/dialogs/logout_dialog.dart'; // For iOS style icons

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: scaffoldPaddingVar * 3,
            color: buttonColorVar,
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Placeholder for profile image
                ),
                Center(
                  child: Text(
                    'User Name',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: buttonTextColorVar),
                  ),
                ),
                Center(
                  child: Text(
                    'email@example.com',
                    style: TextStyle(
                      color: buttonTextColorVar,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(CupertinoIcons.person_solid),
            title: const Text('My Workouts'),
            onTap: () {
              // Navigate to My Workouts page
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.gear),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to Settings page
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.arrow_right_circle),
            title: const Text('Log Out'),
            onTap: () async {
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (_) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
