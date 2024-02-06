// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfit/screens/update.dart';
import 'package:myfit/screens/widgets/card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

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
          height = userDoc['height'];
          weight = userDoc['weight'];
          uid = user.uid;
          water_intake = (userDoc['water'] ?? 0).toInt();
          calorie_intake = (userDoc['calorie'] ?? 0).toInt();
        });
      });
    }
  }

  String caps(String username) {
    return username[0].toUpperCase() + username.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Welcome Back!",
                            style: GoogleFonts.roboto(
                                fontSize: 30, fontWeight: FontWeight.w900,),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(caps(userName),
                              style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700])),
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
                        Icons.logout,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                CardWidget(height: height, weight: weight),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE0F4FF),
                          borderRadius: BorderRadius.circular(10)),
                      height: 280,
                      width: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            child: Image.asset('lib/assets/images/water.png'),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                water_intake.toString(),
                                style: TextStyle(
                                    color: Color(0xff39A7FF),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text("/" + 3700.toString(),
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
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
                              style: GoogleFonts.roboto(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE0F4FF),
                          borderRadius: BorderRadius.circular(10)),
                      height: 280,
                      width: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            child: Image.asset('lib/assets/images/cal.png'),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                calorie_intake.toString(),
                                style: TextStyle(
                                     color: Color(0xff39A7FF),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text("/" + 2500.toString(),
                                  style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
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
                              style: GoogleFonts.roboto(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
