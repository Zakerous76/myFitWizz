// database.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfitwizz/services/cloud_crud/cloud_constants.dart';

class ExercisesDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getExercises() async {
    try {
      QuerySnapshot querySnapshot =
          await _db.collection(exercisesCollectionName).get();
      return querySnapshot.docs
          .map((doc) => {
                nameFieldname: doc[nameFieldname],
                bodyPartFieldname: doc[bodyPartFieldname],
                categoryFieldname: doc[categoryFieldname],
                descriptionFieldname: doc[descriptionFieldname],
                ytLinkFieldname: doc[ytLinkFieldname],
              })
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getExercisesByCategory(
      String category) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection(exercisesCollectionName)
          .where(categoryFieldname, isEqualTo: category)
          .get();
      print(categoryFieldname + category);
      print(querySnapshot.docs.toString());
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> addExercise(Map<String, dynamic> exerciseData) async {
    await _db
        .collection(
          exercisesCollectionName,
        )
        .add(
          exerciseData,
        );
  }
}
