// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          child: Text("Add Workout!"),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Enter title",
              prefixIcon: Icon(Icons.topic),
              labelText: "Title"),
          controller: titleController,
          validator: (value) {
            if (value == "") {
              return "Value cant be null";
            } else {
              return null;
            }
          },
        ),
      ],
    )));
  }
}
