import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:go_athletics/Extra/data_point.dart';
import 'package:go_athletics/screens/dietchartlogpage.dart';

class DietStatsPage extends StatefulWidget {
  const DietStatsPage({Key? key}) : super(key: key);

  @override
  _DietStatsPageState createState() => _DietStatsPageState();
}

class _DietStatsPageState extends State<DietStatsPage> {
  final List<DataPoint> dietDataList = [];
  List<DataPoint> dataPoints = [];

  late final TextEditingController logNumberController;
  late final TextEditingController caloriesController;
  late final TextEditingController dateController;

  Set<double> logNumbers = Set();

  @override
  void initState() {
    super.initState();
    logNumberController = TextEditingController();
    caloriesController = TextEditingController();
    dateController = TextEditingController(); // Initialize date controller
  }

  void addDietLog() {
    double logNumber = double.tryParse(logNumberController.text) ?? 0;
    double calories = double.tryParse(caloriesController.text) ?? 0;
    DateTime date = DateTime.tryParse(dateController.text) ?? DateTime.now(); 

    if (!logNumbers.contains(logNumber)) {
      setState(() {
        dietDataList.add(DataPoint(logNumber, calories, date)); 
        dataPoints.add(DataPoint(logNumber, calories, date)); 
        logNumbers.add(logNumber);
      });

      logNumberController.clear();
      caloriesController.clear();
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
        title: const Text('Diet Stats'),
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
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: caloriesController,
                decoration: InputDecoration(labelText: 'Calories'),
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
                onPressed: addDietLog,
                child: Text('Add Diet Log'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DietChartStatsPage(dietDataList: dietDataList),
                    ),
                  );
                },
                child: Text('View Diet Chart Logs'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLineChart(List<DataPoint> dataPoints) {
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
              return FlSpot(dataPoint.logNumber, dataPoint.calories);
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