// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/models/calorie.dart';
import 'package:http/http.dart' as http;

class CardWidget extends StatefulWidget {
  double height;
  double weight;
  CardWidget({Key? key, required this.height, required this.weight});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  double h = 0;
  double w = 0;
  double age = 0;

  User? user = FirebaseAuth.instance.currentUser;

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
          h = (userDoc['height'] ?? 0).toDouble() / 100;
          w = (userDoc['weight'] ?? 0).toDouble();
          age = (userDoc['age'] ?? 0).toDouble();
        });
      });
    }
  }

  List<CalorieModel> calorie_list = [];

Future<void> getData() async {
  try {
    final response = await http.post(
      Uri.parse('https://gym-calculations.p.rapidapi.com/calculate-macronutrient-ratios'),
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': '017b7e528dmsh55e7f82a92b3be3p1d2ac0jsnb38d7c7a70e8',
        'X-RapidAPI-Host': 'gym-calculations.p.rapidapi.com',
      },
      body: jsonEncode({
        'goal': 'maintain',
        'weight': w,
        'height': h,
        'age': age,
        'gender': 'male',
        'activity_level': 'sedentary',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      calorie_list = [CalorieModel.fromJson(data)];
      print('API Response: $data');
    } else {
      // Handle API error
      print('API Error: ${response.statusCode}');
    }
  } catch (e) {
    // Handle general errors (e.g., network issues)
    print('Error: $e');
  }
}

  double cal = 0.0;

  @override
  Widget build(BuildContext context) {
    double calBMI() {
      double heightInMeters = widget.height / 100;
      return widget.weight / (heightInMeters * heightInMeters);
    }

    cal = calBMI();

    String mybmi(double cal) {
      if (cal < 18.5) {
        return "Under Weight";
      } else if (cal > 18.6 && cal < 25) {
        return "Normal Weight";
      } else if (cal > 25 && cal < 30) {
        return "Over Weight";
      } else {
        return "Obese Weight";
      }
    }

    String ans = mybmi(cal);

    return Container(
      decoration: BoxDecoration(
          color: Color(0xffE0F4FF), borderRadius: BorderRadius.circular(10)),
      height: 145,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BMI (Body Mass Index)",
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue[900]),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "You have a $ans !",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[600])),
                          child: Text(
                            "BMI Chart",
                            style: GoogleFonts.poppins(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.network(
                                                'https://www.pnbmetlife.com/content/dam/pnb-metlife/images/icons/bmi-calculator/meter.png'),
                                            const SizedBox(height: 50),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Close',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ]))))),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green[600])),
                        child: Text(
                          "Intake",
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          await getData();

                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              final result = calorie_list.isNotEmpty
                                  ? calorie_list[0].result
                                  : null;

                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      buildText('Protein', result?.protein),
                                      buildText('Fat', result?.fat),
                                      buildText('Carbs', result?.carbs),
                                      buildText('Calories', result?.calories),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Close',
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ]),
            CircleAvatar(
                maxRadius: 42,
                child: Text(
                  cal.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}

Widget buildText(String label, int? value) {
  return Text(
    '$label: ${value != null ? value.toString()+' g' : "N/A"}',
    style: GoogleFonts.poppins(fontSize: 20, color: Colors.blue[800], fontWeight: FontWeight.w600),
  );
}
