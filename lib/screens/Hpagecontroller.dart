import 'package:flutter/material.dart';
import 'package:go_athletics/Extra/logmodel.dart';
import 'package:get/get.dart';

class LogController extends GetxController{
   Rx<List<LogModel>> logs = Rx<List<LogModel>>([]);
  TextEditingController dateTextEditingController = TextEditingController();
  TextEditingController massTextEditingController = TextEditingController();
  late LogModel logModel;
  var itemCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onReady() {
    super.onReady();
  }

  void onClose() {
  }

  addLog(String date, String mass) {
    if (date.isEmpty) {
      const Text('Please select a date.');
      return;
    }

    
    final List<String> dateParts = date.split('/');
    if (dateParts.length == 3) {
      final int day = int.tryParse(dateParts[0]) ?? 0;
      final int month = int.tryParse(dateParts[1]) ?? 0;
      final int year = int.tryParse(dateParts[2]) ?? 0;

      if (day > 0 && day <= 31 && month > 0 && month <= 12) {
        final DateTime formattedDate = DateTime(year, month, day);
        logModel = LogModel(Date: formattedDate, Mass: int.tryParse(mass));
        logs.value.add(logModel);
        itemCount.value = logs.value.length;
        dateTextEditingController.clear();
        massTextEditingController.clear();
      } 
    } 
  }


  void removeLog(int count) {
  if (count >= 0 && count < logs.value.length) {
    logs.value.removeAt(count);
    itemCount.value = logs.value.length;
  }
}
}
