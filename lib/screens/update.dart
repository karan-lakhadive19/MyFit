// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  String intake = "";

  UpdateScreen({super.key, required this.intake});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final controller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateDoc(String controller) async {
  String fieldToUpdate = widget.intake.toLowerCase();
  int newValue = int.tryParse(controller) ?? 0;

  // Get the current value from Firestore
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .get();

  // Calculate the sum of the current and new values
  int currentValue = (userDoc[fieldToUpdate] ?? 0).toInt();
  int sumValue = currentValue + newValue;

  // Update the correct field with the sum
  Map<String, dynamic> dataToUpdate = {
    fieldToUpdate: sumValue,
  };

  await FirebaseFirestore.instance.collection('users').doc(user!.uid).update(dataToUpdate);
}


  @override
  Widget build(BuildContext context) {
    String intake = widget.intake; 

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Text(intake),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Update here",
                  prefixIcon: intake == "Water"
                      ? Icon(Icons.water)
                      : Icon(Icons.food_bank),
                  labelText: "Update",
                ),
                controller: controller,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  updateDoc(controller.text);
                  Navigator.pop(context);
                },
                child: Text("Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

