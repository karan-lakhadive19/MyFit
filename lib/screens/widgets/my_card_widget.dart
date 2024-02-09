// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCardWidget extends StatefulWidget {

  String name;
  double reps;
  double sets;
  String time;

  MyCardWidget({Key? key, required this.name, required this.reps, required this.sets, required this.time}) : super(key: key);

  @override
  State<MyCardWidget> createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  String caps(String title) {
    return title[0].toUpperCase() + title.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        
        height: 150,
        child: Card(
          color: Color.fromARGB(255, 239, 245, 248),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caps(widget.name),
                      style: GoogleFonts.poppins(
                                color: Colors.blue[900],
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sets: '+caps(widget.sets.toString()),
                          style: GoogleFonts.poppins(
                            color: Colors.blue[600],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Reps: '+caps(widget.reps.toString()),
                          style: GoogleFonts.poppins(
                            color: Color(0xff39A7FF),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEEF5FF),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  height: 50,
                  width: 50,
                  
                  child: IconButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('workouts').doc(widget.time).delete();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Color(0xff1176B87),
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
