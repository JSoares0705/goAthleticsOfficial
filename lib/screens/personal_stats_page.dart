import 'package:flutter/material.dart';
import 'package:go_athletics/Extra/personal_data_point.dart';

class PersonalChartStatsPage extends StatelessWidget {
  final List<PersonalDataPoint> personalDataList;

  const PersonalChartStatsPage({Key? key, required this.personalDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Chart Logs'),
      ),
      body: ListView.builder(
        itemCount: personalDataList.length,
        itemBuilder: (context, index) {
          final dataPoint = personalDataList[index];
          return ListTile(
            title: Text('Log Number: ${dataPoint.logNumber}'),
            subtitle: Text('Mass: ${dataPoint.mall} kg\nDate: ${dataPoint.date.toString()}'),
          );
        },
      ),
    );
  }
}
