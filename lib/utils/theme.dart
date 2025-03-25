import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 238, 238, 238),
    primary: Colors.black,
    secondary: Colors.greenAccent,
  ),
  cardColor: const Color.fromRGBO(233, 233, 233, 1.0),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 238, 238, 238),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 16, 18, 29),
    primary: Color.fromARGB(255, 193, 190, 190),
    secondary: Colors.greenAccent,
  ),
  cardColor: const Color.fromRGBO(233, 233, 233, 1.0),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color.fromARGB(255, 16, 18, 29),
);
