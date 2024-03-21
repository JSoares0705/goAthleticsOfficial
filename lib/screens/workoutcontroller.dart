import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/Extra/models.dart';
import 'package:go_athletics/screens/workout_page.dart';

class WorkoutController extends GetxController {
  List<WorkoutModel> workouts = [];
  TextEditingController nameTextEditingController = TextEditingController();

  void addWorkout(WorkoutModel workout) {
    workouts.add(workout);
    nameTextEditingController.clear();
  }

  void removeWorkout(int index) {
    if (index >= 0 && index < workouts.length) {
      workouts.removeAt(index);
    }
  }

  void clearWorkouts() {
    workouts.clear();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    super.dispose();
  }
}
