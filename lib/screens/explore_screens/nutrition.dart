// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myfit/models/nutrition.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  State<Nutrition> createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  final titleController = TextEditingController();
  String titleField = "";

  List<NutritionModel> my_list = [];

  Future<NutritionModel?> getdata(String title) async {
    setState(() {
      titleField = title;
      print("karan: $titleField");
    });
    final apiKey = "fd6cc28ef30d4ac7b7b815e378600866";

    try {
      final response = await http.get(Uri.parse(
          "https://api.spoonacular.com/recipes/guessNutrition?title=$title&apiKey=$apiKey"));

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Parsed data: $data");

        if (data is Map<String, dynamic>) {
          return NutritionModel.fromJson(data);
        } else {
          // Handle unexpected data format
          print("Unexpected data format: $data");
          return null;
        }
      } else {
        // Handle non-200 status code
        print("API request failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<void> fetchData() async {
    NutritionModel? data = await getdata(titleController.text);
    if (data != null) {
      setState(() {
        my_list = [data];
        print("xxxx $my_list");
      });
    }
  }

  String caps(String titleField) {
    return titleField[0].toUpperCase() + titleField.substring(1);
  }

  @override
  void initState() {
    super.initState();
    // fetchData(); // Remove this line from initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 246, 249),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: my_list.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffd8e8ff),
                              borderRadius: BorderRadius.circular(15)),
                          height: 700,
                          width: 800,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    caps(titleField),
                                    style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.blue[900]),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Calories: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].calories?.value} ${my_list[0].calories?.unit}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('MIN: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].calories?.confidenceRange95Percent?.min.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('MAX: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].calories?.confidenceRange95Percent?.max.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Text('Fat: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].fat?.value} ${my_list[0].fat?.unit}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('MIN: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].fat?.confidenceRange95Percent?.min.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('MAX: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].fat?.confidenceRange95Percent?.max.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Text('Protein: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].protein?.value} ${my_list[0].protein?.unit}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('MIN: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].protein?.confidenceRange95Percent?.min.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('MAX: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].protein?.confidenceRange95Percent?.max.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Text('Carbs: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].carbs?.value} ${my_list[0].carbs?.unit}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('MIN: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].carbs?.confidenceRange95Percent?.min.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text('MAX: ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${my_list[0].carbs?.confidenceRange95Percent?.max.toString()}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : my_list.isEmpty
                        ? Text("Search Something!",
                            style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue[900]))
                        : CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        fillColor: Colors.white,
                        hintText: "Search here...",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600],
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffEEF5FF),
                        borderRadius: BorderRadius.circular(20)),
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        fetchData();
                        titleController.clear();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.blue[600],
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
