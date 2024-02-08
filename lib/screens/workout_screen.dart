// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/models/model.dart';
import 'package:http/http.dart' as http;

class Workout extends StatefulWidget {
  String title;

  Workout({super.key, required this.title});

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  late String title;
  List<WorkoutModel> workout_list = [];

  Future<List<WorkoutModel>> getData() async {
    try {
      final response = await http.get(
        Uri.parse("https://exercisedb.p.rapidapi.com/exercises/name/$title"),
        headers: {
          "X-RapidAPI-Key":
              "017b7e528dmsh55e7f82a92b3be3p1d2ac0jsnb38d7c7a70e8",
          "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        workout_list = List<WorkoutModel>.from(
          data.map((i) => WorkoutModel.fromJson(i)),
        );
        return workout_list;
      } else {
        print('API Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    title = widget.title;
    super.initState();
  }
  String caps(String username) {
    return username[0].toUpperCase() + username.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading data'));
              } else if (!snapshot.hasData || workout_list.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  itemCount: workout_list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                         caps(workout_list[index].name.toString()),
                          style: GoogleFonts.roboto(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue[900]),
                        ),
                        
                        Container(
                          height: screen_height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                              workout_list[index].gifUrl.toString()),
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 80,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xffE0F4FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text("Equipment",
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20)),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                        caps(workout_list[index].equipment.toString()) ??
                                            'N/A',
                                        style: TextStyle(
                                            color: Colors.blue[600],
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Color(0xffE0F4FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Target",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20)),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      caps(workout_list[index].target.toString()) ??
                                          'N/A',
                                      style: TextStyle(
                                          color: Colors.blue[600],
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Instructions',style: GoogleFonts.roboto(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue[900])),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 250,
                          child: ListView.builder(
                            itemCount: workout_list[index].instructions!.length,
                            itemBuilder: (context, instructionIndex) {
                              return ListTile(
                                title: Text(
                                  workout_list[index]
                                      .instructions![instructionIndex], style: GoogleFonts.roboto(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue[600])
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
