// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/screens/widgets/add_workout_widget.dart';
import 'package:myfit/screens/widgets/my_card_widget.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddWorkoutWidget();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('workouts').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: Text("Add Workout!")
              );
            }else if(snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }else {
              final docu = snapshot.data!.docs;
              return ListView.builder(itemBuilder: (context, index) {
                 var name = snapshot.data!.docs[index]['workout_name'];
                  var sets = snapshot.data!.docs[index]['sets'];
                  var reps = snapshot.data!.docs[index]['reps'];
                  var time = snapshot.data!.docs[index]['date'];
                  return MyCardWidget(name: name, reps: reps, sets: sets, time: time,);
              },itemCount: docu.length,);
            }
          },
        ),
      )
    );
  }
}
