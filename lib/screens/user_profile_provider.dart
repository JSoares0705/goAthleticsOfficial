import 'package:flutter/material.dart';

class UserProfile {
  String name;
  int age;
  String gender;
  String goals;

  UserProfile({
    required this.name,
    required this.age,
    required this.gender,
    required this.goals,
  });
}

class UserProfileProvider extends ChangeNotifier {
  late UserProfile _userProfile;

  UserProfile get userProfile => _userProfile;

  void setUserProfile(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }
}
