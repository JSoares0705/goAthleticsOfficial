import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_athletics/screens/dietcontroller.dart';

final DietController dietController = Get.put(DietController());

class DietList extends StatefulWidget {
  const DietList({Key? key}) : super(key: key);

  @override
  State<DietList> createState() => _DietListState();
}

class _DietListState extends State<DietList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Options', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 57, 9, 65),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
            child: TextField(
              controller: dietController.NameTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Name of diet',
                hintText: "Eg. Diet 1",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
            child: TextField(
              controller: dietController.MnumberTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Number of meals per day',
                hintText: "Eg. 4",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 10, 10),
            child: TextField(
              controller: dietController.TcalTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Total number of calories per day',
                hintText: "Eg. 3200",
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
              dietController.addDiet(
                name: dietController.NameTextEditingController.text,
                mealNumber: dietController.MnumberTextEditingController.text,
                totalCalories: dietController.TcalTextEditingController.text,
              );
            },
            child: const Text('Add Diet'),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: dietController.diets.value.length,
                itemBuilder: (context, index) {
                  final diet = dietController.diets.value[index];
                  return ListTile(
                    title: Text(
                      diet.name!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${diet.totalCalories} kcal'),
                        Text('${diet.mealNumber} meals'),
                      ],
                    ),
                    trailing: GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        dietController.removeDiet(index);
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
