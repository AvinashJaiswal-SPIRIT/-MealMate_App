import 'package:flutter/material.dart';
import 'package:meal_mate/splash_screen.dart';

void main() {
  runApp(const MealMateApp());
}

class MealMateApp extends StatelessWidget {
  const MealMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD94A38),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD94A38)),
      ),
      home: SplashScreen(),
    );
  }
}
