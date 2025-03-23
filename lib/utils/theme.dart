import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 238, 238, 238),
    primary: Colors.black,
    secondary: Color.fromARGB(255, 237, 135, 112),
  ),
  useMaterial3: true,
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 16, 18, 29),
    primary: Color.fromARGB(255, 228, 228, 228),
    secondary: Color.fromARGB(255, 237, 135, 112),
  ),
  useMaterial3: true,
);
