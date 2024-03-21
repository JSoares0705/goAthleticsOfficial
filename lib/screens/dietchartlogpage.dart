
import 'package:flutter/material.dart';
import 'package:go_athletics/Extra/data_point.dart';
import 'package:intl/intl.dart';


class DietChartStatsPage extends StatelessWidget {
  final List<DataPoint> dietDataList;

  const DietChartStatsPage({Key? key, required this.dietDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Chart Logs'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Here are your logs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: dietDataList.length,
                itemBuilder: (context, index) {
                  final dataPoint = dietDataList[index];
                  return ListTile(
                    title: Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(dataPoint.date)}, Log Number: ${dataPoint.logNumber}, Calories: ${dataPoint.calories}',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

