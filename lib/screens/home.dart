import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myfit/screens/dashboard.dart';
import 'package:myfit/screens/diet.dart';
import 'package:myfit/screens/map.dart';
import 'package:myfit/screens/widgets/card_widget.dart';
import 'package:myfit/screens/workout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  final List<Widget> _screens = [
    // Replace with the actual screen widgets
    Dashboard(),
    WorkoutScreen(),
    MapScreen(),
    Diet()
  ];

  
  int _selectedIndex = 0;

 @override
Widget build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Dashboard',
              ),
              GButton(
                icon: Icons.sports_gymnastics,
                text: 'Workout',
              ),
              GButton(
                icon: Icons.map,
                text: 'Map',
              ),
              GButton(
                icon: Icons.dining_rounded,
                text: 'Diet',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                print(_selectedIndex);
              });
            },
          ),
        ),
      ),
    ),
    body: 
    _screens[_selectedIndex]
  );
}

}
