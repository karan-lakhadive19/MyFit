// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myfit/models/model.dart';

class WorkoutPage extends StatefulWidget {
  String title;

  WorkoutPage({super.key, required this.title});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late String title;
  List<WorkoutModel> workoutList = [];

  Future<List<WorkoutModel>> getData() async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://exercisedb.p.rapidapi.com/exercises/target/$title"),
          headers: {
            "X-RapidAPI-Key":
                "017b7e528dmsh55e7f82a92b3be3p1d2ac0jsnb38d7c7a70e8",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
          });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        workoutList = List<WorkoutModel>.from(
          data.map((i) => WorkoutModel.fromJson(i)),
        );
        return workoutList;
      } else {
        // Handle API error
        print('API Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle general errors (e.g., network issues)
      print('Error: $e');
      return [];
    }
  }

  void test() {
    return;
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;
    if (title == "Chest") {
      title = "pectorals";
    } else if (title == "Tricep") {
      title = "triceps";
    } else if (title == "Back") {
      title = "lats";
    } else if (title == "Bicep") {
      title = "biceps";
    } else if (title == "Shoulder") {
      title = "delts";
    } else if (title == "Legs") {
      title = "quads";
    } else if (title == "Cardio") {
      title = "cardiovascular system";
    } else if (title == "Forearm") {
      title = "forearms";
    } else if (title == "Traps") {
      title = "traps";
    } else if (title == "Neck") {
      title = "levator scapulae";
    }
    // getData(); // Use await if initState can be marked async.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title.toUpperCase(),
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || workoutList.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Container(
                            height: 100,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(workoutList[index].name.toString()),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Secondary Muscles: ' + workoutList[index]
                                          .secondaryMuscles![0]),
                                    ),
                                   
                                    
                                  ],
                                )),
                          ),
                        );
                      },
                      itemCount: workoutList.length,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
