// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myfit/screens/widgets/category_card.dart';
import 'package:myfit/screens/widgets/workout_card.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 246, 249),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                children: [
                  CategoryCard(
                    title: "Chest",
                    url: 'lib/assets/images/chest.png',
                  ),
                  CategoryCard(
                    title: "Tricep",
                    url: 'lib/assets/images/triceps.png',
                  ),
                  CategoryCard(
                    title: "Back",
                    url: 'lib/assets/images/back.png',
                  ),
                  CategoryCard(
                    title: "Bicep",
                    url: 'lib/assets/images/bicep.png',
                  ),
                  CategoryCard(
                    title: "Shoulder",
                    url: 'lib/assets/images/shoulder.png',
                  ),
                  CategoryCard(
                    title: "Legs",
                    url: 'lib/assets/images/leg.png',
                  ),
                  CategoryCard(
                    title: "Cardio",
                    url: 'lib/assets/images/cardio.png',
                  ),
                  CategoryCard(
                    title: "Forearm",
                    url: 'lib/assets/images/forearm.png',
                  ),
                  CategoryCard(
                    title: "Traps",
                    url: 'lib/assets/images/traps.png',
                  ),
                  CategoryCard(
                    title: "Neck",
                    url: 'lib/assets/images/neck.png',
                  ),
                ]),
          ),
        ));
  }
}
