// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfit/models/calorie.dart';
import 'package:myfit/screens/explore_screens/ai_screen.dart';
import 'package:myfit/screens/explore_screens/nutrition.dart';
import 'package:myfit/screens/update.dart';
import 'package:myfit/screens/update_entry.dart';
import 'package:myfit/screens/widgets/card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/screens/widgets/workout_card.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "";
  double height = 0;
  double weight = 0;
  String uid = "";
  int water_intake = 0;
  int calorie_intake = 0;
  double age = 0;
  dynamic my_cals = 0;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void fetchDetails() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Fetch user details from Firestore
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen((DocumentSnapshot userDoc) {
        setState(() {
          userName = userDoc['name'];
          height = (userDoc['height'] ?? 0).toDouble();
          weight = (userDoc['weight'] ?? 0).toDouble();
          uid = user.uid;
          water_intake = (userDoc['water'] ?? 0).toInt();
          calorie_intake = (userDoc['calorie'] ?? 0).toInt();
          age = (userDoc['age'] ?? 0).toDouble();
          getData();
        });
      });
    }
  }

  List<CalorieModel> calorie_list = [];

  Future<void> getData() async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://gym-calculations.p.rapidapi.com/calculate-macronutrient-ratios'),
        headers: {
          'content-type': 'application/json',
          'X-RapidAPI-Key':
              '017b7e528dmsh55e7f82a92b3be3p1d2ac0jsnb38d7c7a70e8',
          'X-RapidAPI-Host': 'gym-calculations.p.rapidapi.com',
        },
        body: jsonEncode({
          'goal': 'maintain',
          'weight': weight,
          'height': height / 100,
          'age': age,
          'gender': 'male',
          'activity_level': 'sedentary',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        calorie_list = [CalorieModel.fromJson(data)];
        print('API Response: $data');
        setState(() {
          my_cals = calorie_list[0].result?.calories;
        });
      } else {
        // Handle API error
        print('API Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle general errors (e.g., network issues)
      print('Error: $e');
    }
  }

  String caps(String username) {
    return username[0].toUpperCase() + username.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Welcome Back!",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(caps(userName),
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900])),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      iconSize: 24,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: Icon(
                        color: Colors.blue[900],
                        Icons.logout,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CardWidget(height: height, weight: weight),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Track your Body',
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[900]),
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE0F4FF),
                            borderRadius: BorderRadius.circular(10)),
                        height: 201,
                        width: 190,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  'lib/assets/images/water.png',
                                  height: 90,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    water_intake.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff39A7FF),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text("/" + 3700.toString() + " ml",
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue[600],
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[600])),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateScreen(
                                            intake: "Water",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[600])),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .update({'water': 0});
                                    },
                                    child: Text(
                                      "Reset",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE0F4FF),
                            borderRadius: BorderRadius.circular(10)),
                        height: 201,
                        width: 190,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  'lib/assets/images/cal.png',
                                  height: 90,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    calorie_intake.toString(),
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff39A7FF),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "/ " +
                                        (calorie_list.isNotEmpty
                                            ? my_cals.toString() +
                                                " cal" // Assuming "cal" is the unit
                                            : "N/A"),
                                    style: GoogleFonts.poppins(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[600])),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateScreen(
                                            intake: "Calorie",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[600])),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .update({'calorie': 0});
                                    },
                                    child: Text(
                                      "Reset",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE0F4FF),
                            borderRadius: BorderRadius.circular(10)),
                        height: 201,
                        width: 190,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  'lib/assets/images/height.png',
                                  height: 90,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    height.toString() + " cm",
                                    style: GoogleFonts.poppins(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[600])),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateScreen(
                                            intake: "Height",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[600])),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .update({'height': 0});
                                    },
                                    child: Text(
                                      "Reset",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffE0F4FF),
                            borderRadius: BorderRadius.circular(10)),
                        height: 201,
                        width: 190,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  'lib/assets/images/scale.png',
                                  height: 90,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    weight.toString() + " kg",
                                    style: GoogleFonts.poppins(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue[600])),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateScreen(
                                            intake: "Weight",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Update",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red[600])),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user!.uid)
                                          .update({'weight': 0});
                                    },
                                    child: Text(
                                      "Reset",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Explore More!",
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[900]),
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Nutrition()));
                        },
                        child: Container(
                          height: 250,
                          width: 220,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE0F4FF),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'lib/assets/images/schedule.png',
                                    width: 250,
                                    height: 200,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("Guess Nutrition",
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue[600],
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18))
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 250,
                        width: 220,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffE0F4FF),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/assets/images/diet.png',
                                  width: 190,
                                  height: 200,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text("Diet Plan",
                                    style: GoogleFonts.poppins(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18))
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AIScreen()));
                        },
                        child: Container(
                          height: 250,
                          width: 220,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffE0F4FF),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'lib/assets/images/ai.png',
                                    width: 190,
                                    height: 200,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text("Chat with AI",
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue[600],
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18))
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
