// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/screens/intro_screens/intro_page_1.dart';
import 'package:myfit/screens/intro_screens/intro_page_2.dart';
import 'package:myfit/screens/intro_screens/intro_page_3.dart';
import 'package:myfit/screens/auth/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            IntroPage1(),
            IntroPage2(),
            IntroPage3()
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Text('SKIP', style: GoogleFonts.poppins(
                  color: Colors.blue[600],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                onTap: () {
                  _controller.jumpToPage(2);
                },
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              onLastPage
                  ? GestureDetector(
                      child: Text('DONE', style: GoogleFonts.poppins(
                  color: Colors.blue[600],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                    )
                  : GestureDetector(
                      child: Text('NEXT', style: GoogleFonts.poppins(
                  color: Colors.blue[600],
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )),
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                    )
            ],
          ),
          alignment: Alignment(0, 0.75),
        )
      ],
    ));
  }
}
