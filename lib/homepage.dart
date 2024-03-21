import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:go_athletics/screens/diet.dart';
import 'package:go_athletics/screens/personalstat.dart';
import 'package:go_athletics/screens/stats.dart';
import 'package:go_athletics/screens/workout.dart';
import 'package:go_athletics/screens/Hpage.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
  const Hpage(),
  ProfileStats(),
  StatsPage(), // Correct instantiation of StatsPage
  const Diets(),
  const Workouts(),
];


  void _onTabTapped(int index) {
    if(index >= 0 && index < _pages.length){
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 57, 9, 65),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 57, 9, 65),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 188, 70, 209),
            padding: const EdgeInsets.all(20),
            gap: 6,
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.house,iconSize: 20,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.users,iconSize: 20,
                text: 'Profile',
              ),
              GButton(
                icon: FontAwesomeIcons.chartSimple, iconSize: 20,
                text: 'Progress',
              ),
              GButton(
                icon: FontAwesomeIcons.utensils,iconSize: 20,
                text: 'Diets',
              ),
              GButton(
                icon: FontAwesomeIcons.dumbbell,iconSize: 20,
                text: 'Workouts',
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onTabTapped,
          ),
        ),
        
      ),
    );
  }
}
