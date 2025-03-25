import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: const Color.fromARGB(255, 238, 238, 238),
    primary: Colors.grey.shade700,
    secondary: Colors.greenAccent.shade700,
  ),
  cardColor: Colors.grey.shade300,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey.shade200,
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 16, 18, 29),
    primary: Colors.grey.shade200,
    secondary: Colors.greenAccent,
  ),
  cardColor: Colors.grey.shade500,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 16, 18, 29),
);
