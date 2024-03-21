import 'package:flutter/material.dart';
import 'package:go_athletics/screens/diet_stats.dart';
import 'package:go_athletics/screens/personal_stats.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DietStatsPage()),
                );
              },
              child: Text('View Diet Stats'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalStatsPage()),
                );
              },
              child: Text('View Personal Stats'),
            ),
          ],
        ),
      ),
    );
  }
}
