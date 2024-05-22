import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfitwizz/services/auth/auth_service.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_constants.dart';

class EditPersonalInfoView extends StatefulWidget {
  @override
  _EditPersonalInfoViewState createState() => _EditPersonalInfoViewState();
}

class _EditPersonalInfoViewState extends State<EditPersonalInfoView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final currentUserId = AuthService.firebase().currentUser?.id;

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Personal Info'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(currentUserId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          _usernameController.text = userData[userNameFieldname] ?? '';
          _ageController.text = userData[ageFieldName] ?? '';
          _heightController.text = userData[heightFieldName] ?? '';
          _weightController.text = userData[weightFieldName] ?? '';
          _genderController.text = userData[genderFieldName] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(labelText: 'Height'),
                ),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(labelText: 'Weight'),
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _savePersonalInfo(),
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _savePersonalInfo() async {
    String userId = currentUserId!; // Replace with the actual user ID
    await AuthService.firebase().updateDisplayName(_usernameController.text);

    FirebaseFirestore.instance.collection('users').doc(userId).update({
      userNameFieldname: _usernameController.text,
      ageFieldName: _ageController.text,
      heightFieldName: _heightController.text,
      weightFieldName: _weightController.text,
      genderFieldName: _genderController.text,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Personal info updated successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update personal info: $error')));
    });
  }
}
