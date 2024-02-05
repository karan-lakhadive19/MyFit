// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  double height;
  double weight;
  CardWidget({Key? key, required this.height, required this.weight});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  double cal = 0.0;

  @override
  Widget build(BuildContext context) {
    double calBMI() {
      double heightInMeters = widget.height / 100;
      return widget.weight / (heightInMeters * heightInMeters);
    }

    cal = calBMI();

    String mybmi(double cal) {
      if(cal<18.5) {
        return "Under Weight";
      }else if(cal>18.6 && cal<25) {
        return "Normal Weight";
      }else if(cal>25 && cal<30){
        return "Over Weight";
      }else {
        return "Obese Weight";
      }
    }

    String ans = mybmi(cal);


    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("BMI (Body Mass Index)"),
              SizedBox(
                height: 2,
              ),
              Text("You have a $ans")
            ],
          ),
          Text(cal.toStringAsFixed(2))
        ],
      ),
    );
  }
}
