import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: const Color(0xff32B768),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'JosefinSans',
    // buttonColor: const Color(0xFF2f4252),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0xff32B768),
      ),
      headlineMedium: TextStyle(
        color: Color(0xff32B768),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
