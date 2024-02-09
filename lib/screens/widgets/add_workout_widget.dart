// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWorkoutWidget extends StatefulWidget {
  const AddWorkoutWidget({super.key});

  @override
  State<AddWorkoutWidget> createState() => _AddWorkoutWidgetState();
}

class _AddWorkoutWidgetState extends State<AddWorkoutWidget> {
  final nameController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void addWorkout(String nameController, String setsController,
      String repsController) async {
    double sets = double.parse(setsController);
    double rep = double.parse(repsController);

    DateTime now = DateTime.now();

    String formattedDate =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    try {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('workouts')
          .doc(now.toString())
          .set({
        'workout_name': nameController,
        'sets': sets,
        'reps': rep,
        'date': now.toString()
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      shape: Border.all(style: BorderStyle.none),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        height: 270,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Workout Name',
                    labelStyle: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: setsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Sets',
                    labelStyle: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: repsController,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    labelText: 'Reps',
                    labelStyle: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900]
              ),
                onPressed: () {
                  addWorkout(nameController.text, setsController.text,
                      repsController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  "Add Workout",
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
