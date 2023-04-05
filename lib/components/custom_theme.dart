import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData cuatomTheme() {
    return ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.blue.shade900,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              letterSpacing: .5,
            )));
  }
}
