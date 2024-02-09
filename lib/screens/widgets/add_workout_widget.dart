// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      
      content: Container(
        height: 300,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Workout Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: setsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Sets"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: repsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Reps"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    addWorkout(nameController.text, setsController.text,
                        repsController.text);
                        Navigator.pop(context);
                  },
                  child: Text("Add Workout"))
            ],
          ),
        ),
      ),
    );
  }
}
