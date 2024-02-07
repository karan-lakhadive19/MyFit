// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      decoration: BoxDecoration(
          color: Color(0xffE0F4FF), borderRadius: BorderRadius.circular(10)),
      height: 140,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BMI (Body Mass Index)",
                    style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue[900]),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "You have a $ans !",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[600])),
                      child: Text(
                        "BMI Chart",
                        style: GoogleFonts.roboto(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.network(
                                            'https://www.pnbmetlife.com/content/dam/pnb-metlife/images/icons/bmi-calculator/meter.png'),
                                        const SizedBox(height: 50),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Close',
                                            style: GoogleFonts.roboto(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ])))))
                ]),
            CircleAvatar(
                maxRadius: 42,
                child: Text(
                  cal.toStringAsFixed(2),
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
