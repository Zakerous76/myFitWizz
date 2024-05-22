import 'package:flutter/material.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_constants.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_exercises.dart';

class AddExerciseView extends StatefulWidget {
  const AddExerciseView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddExerciseViewState createState() => _AddExerciseViewState();
}

class _AddExerciseViewState extends State<AddExerciseView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bodyPartController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ytLinkController = TextEditingController();
  final ExercisesDatabaseService _databaseService = ExercisesDatabaseService();

  void _submitExercise() {
    if (_formKey.currentState!.validate()) {
      final exercise = {
        nameFieldname: _nameController.text.trim(),
        bodyPartFieldname: _bodyPartController.text.trim(),
        categoryFieldname: _categoryController.text.trim(),
        descriptionFieldname: _descriptionController.text.trim(),
        ytLinkFieldname: _ytLinkController.text.trim(),
      };
      _databaseService.addExercise(exercise).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exercise added successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add exercise: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Exercise')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _bodyPartController,
                decoration: const InputDecoration(labelText: 'Body Part'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a body part' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a category' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                controller: _ytLinkController,
                decoration: const InputDecoration(labelText: 'YouTube Link'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a YouTube link' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitExercise();
                  Navigator.pop(context);
                },
                child: const Text('Upload Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
