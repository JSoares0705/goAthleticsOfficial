import 'package:get/get.dart';
import 'package:go_athletics/Extra/models.dart';

class ExerciseController extends GetxController {
  final exercises = <ExerciseModel>[];

  void addExercise(ExerciseModel exercise, WorkoutModel workout) {
    exercises.add(exercise);

    // Update the exercises list inside the workout
    workout.exercises.add(exercise);
  }
  
}
