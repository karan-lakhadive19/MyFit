// signup
// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 243, 246, 249),
          title: Text(
            "Create Account",
            style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.blue[900]),
          ),
        ),
        body: Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 246, 249),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,),
                        child: Image.asset('lib/assets/images/yoga.png', height: 200,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.person, color: Colors.blue[900]),
                            labelText: 'Name',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 15,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
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
                            icon: Icon(Icons.email, color: Colors.blue[900]),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          controller: emailController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.blue[900]),
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
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
                            icon: Icon(Icons.cake, color: Colors.blue[900]),
                            labelText: 'Age',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
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
                            icon: Icon(Icons.height, color: Colors.blue[900]),
                            labelText: 'Height (cm)',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
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
                            icon: Icon(
                              Icons.monitor_weight_outlined,
                              color: Colors.blue[900],
                            ),
                            labelText: 'Weight',
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          controller: weightController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900]),
                        onPressed: () {
                          startAuth();
                        },
                        child: Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account? ",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[600]),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text("Login",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900])))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
