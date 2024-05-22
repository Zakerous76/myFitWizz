import 'package:flutter/material.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_constants.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_exercises.dart';
import 'package:myfitwizz/views/thesaurus/exercise_view.dart';

class ThesaurusView extends StatefulWidget {
  const ThesaurusView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThesaurusViewState createState() => _ThesaurusViewState();
}

class _ThesaurusViewState extends State<ThesaurusView> {
  final ExercisesDatabaseService _databaseService = ExercisesDatabaseService();
  late Future<List<Map<String, dynamic>>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = _databaseService.getExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thesaurus')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _exercisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> exercises = snapshot.data!;
            return ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                var exercise = exercises[index];
                return ListTile(
                  title: Text(exercise[nameFieldname]),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(exercise[bodyPartFieldname]),
                  ),
                  trailing: Text(exercise[categoryFieldname]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExerciseView(exercise: exercises[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }
}
