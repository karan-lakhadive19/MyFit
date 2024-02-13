
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/screens/auth/signup.dart';
import 'package:myfit/screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passController = TextEditingController();

    FirebaseAuth auth = FirebaseAuth.instance;

    void login(String email, String password) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        } else if (e.code == 'wrong-password') {
          print(e);
        }
      }
    }

    startAuth() {
      final _valid = _formKey.currentState!.validate();
      if (_valid) {
        _formKey.currentState!.save();

        login(emailController.text, passController.text);
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 243, 246, 249),
          title: Text(
            "Login",
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
              child: Column(
                children: [
                  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30,),
                        child: Image.asset('lib/assets/images/meditation.png', height: 200,),
                      ),
                      SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900]),
                            onPressed: () {
                              startAuth();
                            },
                            child: Text(
                              "Login",
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
                                "Create account? ",
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
                                            builder: (context) => Signup()));
                                  },
                                  child: Text("Signup",
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
                ],
              ),
            ),
          ),
        ));
  }
}
