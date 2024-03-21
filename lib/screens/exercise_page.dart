import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/screens/exercisecontroller.dart';
import 'package:go_athletics/Extra/models.dart';

class ExercisePage extends StatelessWidget {
  final ExerciseController exerciseController = Get.find();
  final WorkoutModel workout;

  ExercisePage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final setsController = TextEditingController();
    final repsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exercise to ${workout.name}', style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 57, 9, 65),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
            ),
            TextField(
              controller: setsController,
              decoration: const InputDecoration(labelText: 'Sets'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: repsController,
              decoration: const InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final sets = int.tryParse(setsController.text) ?? 0;
                final reps = int.tryParse(repsController.text) ?? 0;

                if (name.isNotEmpty) {
                  exerciseController.addExercise(
                    ExerciseModel(
                     exercise: name,
                      sets: sets,
                      reps: reps,
                    ),
                    workout,
                  );

                  // Clear input fields
                  nameController.clear();
                  setsController.clear();
                  repsController.clear();
                }
              },
              child: const Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
