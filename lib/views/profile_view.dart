// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/constants/paths.dart';
import 'package:myfitwizz/constants/routes.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/utilities/dialogs/logout_dialog.dart'; // For iOS style icons

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = FirebaseAuth.instance.currentUser!.email ?? "";

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
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(iconImgPath),
                ),
                const Center(
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
                    email,
                    style: const TextStyle(
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
            title: const Text('Personal Information'),
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(
                personalInfoRoute,
              );
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.gear),
            title: const Text('Edit Info'),
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(
                editPersonalInfoRoute,
              );
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
