// import 'package:flutter/material.dart';

// class ColorPalette {
//   static const Color primaryColor = Color(0xFF186cdb);
//   static const Color primaryVariant = Color(0xFF3700B3);
//   static const Color secondaryColor = Color(0xFF03DAC6);
//   static const Color secondaryVariant = Color(0xFF018786);
//   static const Color backgroundColor = Color(0xFFF5F5F5);
//   static const Color surfaceColor = Color(0xFFFFFFFF);
//   static const Color errorColor = Color(0xFFB00020);
//   static const Color onPrimaryColor = Color(0xFFFFFFFF);
//   static const Color onSecondaryColor =Color(0xFF000000);
//   static const Color onBackgroundColor = Color.fromRGBO(38, 40, 55, 1);//Color(0xFF000000);
//   static const Color onSurfaceColor = Color(0xFF000000);
//   static const Color onErrorColor = Color(0xFFFFFFFF);
// }

import 'package:flutter/material.dart';

class ColorPalette {
  // Primary colors
  static const Color primaryColor = Color(0xFF186cdb);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  
  // Secondary colors
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color onSecondaryColor = Color(0xFF000000);
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light mode background
  static const Color darkBackgroundColor = Color.fromRGBO(38, 40, 55, 1); // Dark mode background
  static const Color onBackgroundColor = Color.fromRGBO(38, 40, 55, 1);// Text on light background
  static const Color onDarkBackgroundColor = Color(0xFFFFFFFF); // Text on dark background
  
  // Surface colors
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF000000);
  
  // Error colors
  static const Color errorColor = Color(0xFFB00020);
  static const Color onErrorColor = Color(0xFFFFFFFF);
}
