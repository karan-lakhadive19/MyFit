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
      height: 100,
      width: double.infinity,
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text("BMI (Body Mass Index)"),
            SizedBox(
              height: 2,
            ),
            Text("You have a $ans"),
            SizedBox(
              height: 2,
            ),
            ElevatedButton(
                child: Text("View More"),
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network('https://www.pnbmetlife.com/content/dam/pnb-metlife/images/icons/bmi-calculator/meter.png'),
                                  const SizedBox(height: 50),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ])))))
          ]),
          CircleAvatar(child: Text(cal.toStringAsFixed(2)))
        ],
      ),
    );
  }
}
