import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfit/screens/update.dart';
import 'package:myfit/screens/widgets/card_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Welcome Back!" + userName),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Text(
                            userName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: Icon(Icons.logout),
                    ),
                  ],
                ),
                CardWidget(height: height, weight: weight),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      height: 240,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            child: Image.asset(
                                'lib/assets/images/water.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            water_intake.toString() + "/" + 3700.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
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
                            child: Text("Update"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.red),
                      height: 240,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            child: Image.asset(
                                'lib/assets/images/cal.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            calorie_intake.toString() + "/" + 2500.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
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
                            child: Text("Update"),
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
