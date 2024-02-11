// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfit/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfit/screens/home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final heightController = TextEditingController();
    final weightController = TextEditingController();
    final ageController = TextEditingController();

    FirebaseAuth auth = FirebaseAuth.instance;

    void signupUser(String _email, String _password) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

            double height = double.parse(heightController.text);
            double weight = double.parse(weightController.text);
            int age = int.parse(ageController.text);

        // Add user details to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'pass': passController.text,
          'height': height,
          'weight': weight,
          "water": 0.0,
          "calorie": 0.0,
          "age": age
          // Add other user details as needed
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // Handle weak password error
        } else if (e.code == 'email-already-in-use') {
          // Handle email already in use error
        }
      } catch (e) {
        // Handle other errors
        print(e);
      }
    }

    startAuth() {
      final _valid = _formKey.currentState!.validate();
      if (_valid) {
        _formKey.currentState!.save();

        signupUser(emailController.text, passController.text);
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("Signup")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter name",
                          prefixIcon: Icon(Icons.person),
                          labelText: "Name"),
                      controller: nameController,
                      validator: (value) {
                        if (value == "") {
                          return "Value cant be null";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter email",
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email"),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.password),
                          labelText: "Password"),
                      controller: passController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter age",
                          prefixIcon: Icon(Icons.power_off_outlined),
                          labelText: "Age"),
                      controller: ageController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter height",
                          prefixIcon: Icon(Icons.height),
                          labelText: "Height"),
                      controller: heightController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter weight",
                          prefixIcon: Icon(Icons.monitor_weight),
                          labelText: "weight"),
                      controller: weightController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        startAuth();
                      },
                      child: Text("Signup")),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
