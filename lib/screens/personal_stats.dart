import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:go_athletics/Extra/personal_data_point.dart';
import 'package:go_athletics/screens/personal_stats_page.dart';

class PersonalStatsPage extends StatefulWidget {
  const PersonalStatsPage({Key? key}) : super(key: key);

  @override
  _PersonalStatsPageState createState() => _PersonalStatsPageState();
}

class _PersonalStatsPageState extends State<PersonalStatsPage> {
  final List<PersonalDataPoint> personalDataList = [];
  List<PersonalDataPoint> dataPoints = [];

  late final TextEditingController logNumberController;
  late final TextEditingController mallController;
  late final TextEditingController dateController;

  Set<double> logNumbers = Set();

  @override
  void initState() {
    super.initState();
    logNumberController = TextEditingController();
    mallController = TextEditingController();
    dateController = TextEditingController(); // Initialize date controller
  }

  void addPersonalLog() {
    double logNumber = double.tryParse(logNumberController.text) ?? 0;
    double mall = double.tryParse(mallController.text) ?? 0;
    DateTime date = DateTime.tryParse(dateController.text) ?? DateTime.now(); // Parse the selected date

    if (!logNumbers.contains(logNumber)) {
      setState(() {
        personalDataList.add(PersonalDataPoint(logNumber, mall, date)); // Add the selected date to the DataPoint
        dataPoints.add(PersonalDataPoint(logNumber, mall, date)); // Add the selected date to the DataPoint
        logNumbers.add(logNumber);
      });

      logNumberController.clear();
      mallController.clear();
      dateController.clear();
    } else {
      // Show error message or handle repetition case
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Log number already exists. Please enter a unique log number."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Stats'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 300,
                child: buildLineChart(dataPoints),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: logNumberController,
                decoration: InputDecoration(labelText: 'Log Number'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: mallController,
                decoration: InputDecoration(labelText: 'Mass (kg)'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: addPersonalLog,
                child: Text('Add Personal Log'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalChartStatsPage(personalDataList: personalDataList),
                    ),
                  );
                },
                child: Text('View Personal Chart Logs'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLineChart(List<PersonalDataPoint> dataPoints) {
    if (dataPoints.isEmpty) {
      return Container();
    }

    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 10000,),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints.map((dataPoint) {
              return FlSpot(dataPoint.logNumber, dataPoint.mall);
            }).toList(),
            isCurved: true,
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (value % 5000 == 0) {
      return Text(
        value.toInt().toString(),
        style: TextStyle(fontSize: 12),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
