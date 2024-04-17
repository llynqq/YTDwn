import 'package:flutter/material.dart';
import './pages/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? Brightness.light
                : Brightness.dark,
      ),
      home: OnBoardingScreen(),
    );
  }
}
