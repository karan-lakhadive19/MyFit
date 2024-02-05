import 'package:flutter/material.dart';

class WCard extends StatefulWidget {

  String title;
  WCard({super.key, required this.title});

  @override
  State<WCard> createState() => _WCardState();
}

class _WCardState extends State<WCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        height: 80,
        width: 50,
        child: Column(
          children: [
            Image.network('https://media.post.rvohealth.io/wp-content/uploads/2020/02/man-exercising-plank-push-up-732x549-thumbnail.jpg'),
            SizedBox(height: 2,),
            Text(widget.title, style: TextStyle(color: Colors.white),)
          ],
        )
      ),
    );
  }
}