import 'package:flutter/material.dart';

class Style {
  static Color medicineDescriptionColorPrimary =
      Color.fromARGB(255, 52, 18, 125);
  static Color medicineDescriptionColorSecondary =
      Color.fromARGB(255, 84, 62, 131);
  static Color medicineDescriptionColorMain = Color.fromARGB(255, 42, 11, 107);
  static Color flashLightColor = Colors.grey.shade400;

  static Color homeScanButtonColor = Colors.deepPurple.shade500;

  static var themeData = ThemeData(
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              color: Color.fromARGB(255, 42, 11, 107),
              fontWeight: FontWeight.bold),
          headline1: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
          headline2: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          headline3: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
      iconTheme: const IconThemeData(color: Color.fromRGBO(55, 32, 104, 1.0)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme:
              IconThemeData(color: Color.fromRGBO(55, 32, 104, 1.0))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(55, 32, 104, 1.0))));
}
