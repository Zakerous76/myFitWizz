import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});

  Future<Map<String, dynamic>?> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final userId = user.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User ID: ${userData['user_id']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Username: ${userData['user_name']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Age: ${userData['age']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Gender: ${userData['gender']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Height: ${userData['height']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Text('Weight: ${userData['weight']}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
