// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:google_fonts/google_fonts.dart';
import 'package:myfit/services/notification_service.dart';

DateTime scheduleTime = DateTime.now();

class UpdateScreen extends StatefulWidget {
  String intake = "";

  UpdateScreen({super.key, required this.intake});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final controller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateDoc(String controller) async {
  String fieldToUpdate = widget.intake.toLowerCase();
  int newValue = int.tryParse(controller) ?? 0;

  // Get the current value from Firestore
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .get();

  // Calculate the sum of the current and new values
  int currentValue = (userDoc[fieldToUpdate] ?? 0).toInt();
  int sumValue = currentValue + newValue;

  // Update the correct field with the sum
  Map<String, dynamic> dataToUpdate = {
    fieldToUpdate: sumValue,
  };

  await FirebaseFirestore.instance.collection('users').doc(user!.uid).update(dataToUpdate);
}


  @override
  Widget build(BuildContext context) {
    String intake = widget.intake; 

    return AlertDialog(
      content: Container(
        height: 180,
          child: Column(
            children: [
              Container(
                child: Text(intake, style: GoogleFonts.poppins(color: Colors.blue[900], fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: intake,
                    labelStyle: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                controller: controller,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600]),
                        onPressed: () {
                          updateDoc(controller.text);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Update",
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      )
            //   DatePickerTxt(),
            // ScheduleBtn(),
            ],
          ),
        ),
      );
    
  }
}

// class DatePickerTxt extends StatefulWidget {
//   const DatePickerTxt({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DatePickerTxt> createState() => _DatePickerTxtState();
// }

// class _DatePickerTxtState extends State<DatePickerTxt> {
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         picker.DatePicker.showDateTimePicker(
//           context,
//           showTitleActions: true,
//           onChanged: (date) => scheduleTime = date,
//           onConfirm: (date) {},
//         );
//       },
//       child: const Text(
//         'Select Date Time',
//         style: TextStyle(color: Colors.blue),
//       ),
//     );
//   }
// }

// class ScheduleBtn extends StatelessWidget {
//   const ScheduleBtn({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: const Text('Schedule notifications'),
//       onPressed: () {
//         debugPrint('Notification Scheduled for $scheduleTime');
//         NotificationService().scheduleNotification(
//             title: 'Scheduled Notification',
//             body: '$scheduleTime',
//             scheduledNotificationDateTime: scheduleTime);
//       },
//     );
//   }
// }

