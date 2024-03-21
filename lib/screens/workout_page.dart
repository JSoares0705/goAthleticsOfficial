import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/Extra/models.dart';
import 'exercise_page.dart';

class WorkoutPage extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutPage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name, style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 57, 9, 65),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: workout.exercises.length,
              itemBuilder: (context, index) {
                final exercise = workout.exercises[index];
                return ListTile(
                  title: Text(exercise.exercise),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sets: ${exercise.sets.toString()}"),
                      Text("Reps: ${exercise.reps.toString()}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ExercisePage(workout: workout));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
