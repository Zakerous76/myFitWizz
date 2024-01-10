import 'package:flutter/material.dart';
import 'package:myfitwizz/constants/constants.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_exercises.dart';
import 'package:myfitwizz/views/thesaurus/exercise_view.dart';

class ExercisesByCategoryView extends StatefulWidget {
  final String category;

  const ExercisesByCategoryView({super.key, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _ExercisesByCategoryViewState createState() =>
      _ExercisesByCategoryViewState();
}

class _ExercisesByCategoryViewState extends State<ExercisesByCategoryView> {
  late Future<List<Map<String, dynamic>>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = ExercisesDatabaseService().getExercisesByCategory(
      widget.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises for ${widget.category}'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _exercisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
            return const Center(child: Text('No exercises found'));
          }
        },
      ),
    );
  }
}
