import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/screens/workoutcontroller.dart';
import 'package:go_athletics/Extra/models.dart';
import 'workout_page.dart';

class WorkoutList extends StatelessWidget {
  final WorkoutController workoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Options', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 57, 9, 65),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
            child: TextField(
              controller: workoutController.nameTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Workout Name',
                hintText: "Eg. Leg Day",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                isDense: true,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = workoutController.nameTextEditingController.text;

              // Create a new workout with the given name
              final workout = WorkoutModel(name: name, exercises: []);

              // Add workout
              workoutController.addWorkout(workout);

              // Clear input field
              workoutController.nameTextEditingController.clear();
            },
            child: const Text('Create Workout'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: workoutController.workouts.length,
              itemBuilder: (context, index) {
                final workout = workoutController.workouts[index];
                return ListTile(
                  title: Text(workout.name),
                  trailing: GestureDetector(
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Get.to(() => WorkoutPage(workout: workout));
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
