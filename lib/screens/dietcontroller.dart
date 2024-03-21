import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/Extra/dietmodel.dart';

class DietController extends GetxController {
  TextEditingController MnumberTextEditingController = TextEditingController();
  TextEditingController TcalTextEditingController = TextEditingController();
  TextEditingController NameTextEditingController = TextEditingController();

  Rx<List<DietModel>> diets = Rx<List<DietModel>>([]);
  var itemCount = 0.obs;

  void addDiet({required String name, required String mealNumber, required String totalCalories}) {
    DietModel dietModel = DietModel(
      name: name,
      mealNumber: mealNumber,
      totalCalories: totalCalories,
    );
    diets.value.add(dietModel);
    itemCount.value = diets.value.length;
    MnumberTextEditingController.clear();
    TcalTextEditingController.clear();
    NameTextEditingController.clear();
  }

  void clearDiets() {
  diets.value = [];
}

  void removeDiet(int index) {
    if (index >= 0 && index < diets.value.length) {
      diets.value.removeAt(index);
      itemCount.value = diets.value.length;
    }
  }
}
