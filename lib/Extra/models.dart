class ExerciseModel {
  final String exercise;
  final int sets;
  final int reps;

  ExerciseModel({
    required this.exercise,
    required this.sets,
    required this.reps,
  });
}

class WorkoutModel {
  final String name;
  final List<ExerciseModel> exercises;

  WorkoutModel({
    required this.name,
    required this.exercises,
  });
}
