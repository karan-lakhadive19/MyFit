import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfit/screens/widgets/card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  String userName = "";
  double height = 0;
  double weight = 0;
  String uid = "";

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }


  void fetchDetails() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Fetch user details from Firestore
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userName = userDoc['name'];
        height = userDoc['height'];
        weight = userDoc['weight'];
        uid = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Welcome Back!"),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Text(
                            userName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: Icon(Icons.logout),
                    ),
                  ],
                ),
                CardWidget(height: height, weight: weight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
