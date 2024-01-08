import 'package:flutter/material.dart';
import 'package:health_reminders/pages/landing.dart';
import 'package:health_reminders/styles/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: white,
      ),
      home: landingPage(),
    );
  }
}
