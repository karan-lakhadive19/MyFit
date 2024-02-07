import 'package:flutter/material.dart';

class WCard extends StatefulWidget {

  String title;
  String url;
  WCard({super.key, required this.title, required this.url});

  @override
  State<WCard> createState() => _WCardState();
}

class _WCardState extends State<WCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 280,
        width: 180,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(widget.url),
            ),
            SizedBox(height: 2,),
            Text(widget.title, style: TextStyle(color: Colors.white),)
          ],
        )
      ),
    );
  }
}