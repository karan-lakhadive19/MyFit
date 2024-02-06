import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('lib/assets/images/screen3.png'),
          ),
        ),
      
    );
  }
}