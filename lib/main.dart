import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfit/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myfit/screens/onboarding.dart';
import 'package:myfit/services/notification_service.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  // tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return HomePage();
          }else {
            return OnBoardingScreen();
          }
        },
      ),
    );
  }
}