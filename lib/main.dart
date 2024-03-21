import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/firebase_options.dart';
import 'package:go_athletics/homepage.dart';
import 'package:go_athletics/login.dart';
import 'package:go_athletics/screens/dietlist.dart';
import 'package:go_athletics/screens/exercisecontroller.dart';
import 'package:go_athletics/screens/workoutcontroller.dart';
import 'package:go_athletics/screens/workoutlist.dart';
import 'package:go_athletics/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
Get.put(WorkoutController());
Get.put(ExerciseController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const LoginPage()),
      GetPage(name: '/signup', page: () => const Signup()),
      GetPage(name: '/homepage', page: () => const HomePage()),
      GetPage(name: '/workoutlist', page: () => WorkoutList()),
      GetPage(name: '/dietlist', page: () =>  const DietList()),
    ],
  ));
}
