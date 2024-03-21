import 'package:flutter/foundation.dart';

class WorkoutModel {
  final String? name;
  final List<ExerciseModel> exercises; // List of exercises

  WorkoutModel({
    required this.exercises,
    this.name,
  });
}

class ExerciseModel {
  final String? exercise;
  final int? sets;
  final int? reps;

  ExerciseModel({
    @required this.exercise,
    @required this.sets,
    @required this.reps,
  });
}
