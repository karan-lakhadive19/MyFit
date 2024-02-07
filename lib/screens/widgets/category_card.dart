import 'package:flutter/material.dart';
import 'package:myfit/screens/workout.dart';
import 'package:myfit/screens/workout_page.dart';

class CategoryCard extends StatelessWidget {

  String title;
  String url;

  CategoryCard({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkoutPage(title: title)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 202, 220, 246), borderRadius: BorderRadius.circular(15)),
        height: 150,
        width: 150,
        child: Column(
          children: [
            Image.asset(
              url,
              height: 160,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
