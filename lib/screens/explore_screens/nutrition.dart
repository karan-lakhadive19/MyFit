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

  List<NutritionModel> my_list = [];

  Future<NutritionModel?> getdata(String title) async {
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

  @override
  void initState() {
    super.initState();
    // fetchData(); // Remove this line from initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: my_list.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Calories: ${my_list[0].calories?.value} ${my_list[0].calories?.unit}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'MIN: ${my_list[0].calories?.confidenceRange95Percent?.min.toString()}'
                            'Max: ${my_list[0].calories?.confidenceRange95Percent?.max.toString()}'
                          ),
                          Text(
                            'Fat: ${my_list[0].fat?.value} ${my_list[0].fat?.unit}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'MIN: ${my_list[0].fat?.confidenceRange95Percent?.min.toString()}'
                            'Max: ${my_list[0].fat?.confidenceRange95Percent?.max.toString()}'
                          ),
                          Text(
                            'Protein: ${my_list[0].protein?.value} ${my_list[0].protein?.unit}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'MIN: ${my_list[0].protein?.confidenceRange95Percent?.min.toString()}'
                            'Max: ${my_list[0].protein?.confidenceRange95Percent?.max.toString()}'
                          ),
                          Text(
                            'Carbs: ${my_list[0].carbs?.value} ${my_list[0].carbs?.unit}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'MIN: ${my_list[0].carbs?.confidenceRange95Percent?.min.toString()}'
                            'Max: ${my_list[0].carbs?.confidenceRange95Percent?.max.toString()}'
                          ),
                        ],
                      )
                    : my_list.isEmpty
                        ? Text("No data found.")
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
                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      fetchData();
                      titleController.clear();
                    },
                    
                    child: Text("Search"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Adjust the value as needed
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
