import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('lib/assets/images/screen1.png'),
          ),
        ),
      
    );
  }
}