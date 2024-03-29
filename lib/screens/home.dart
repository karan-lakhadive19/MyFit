// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myfit/screens/category.dart';
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
    Category(),
    WorkoutScreen(),
  ];

  
  int _selectedIndex = 0;

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 243, 246, 249),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
              activeColor: Colors.blue[600],
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color(0xffE0F4FF),
              color: Colors.blue[300],
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: Icons.category,
                  text: 'Category',
                ),
                GButton(
                  icon: Icons.sports_gymnastics,
                  text: 'Workout',
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
    ),
    body: 
     _selectedIndex < _screens.length ? _screens[_selectedIndex] : Container(),

  );
}

}
