import 'package:flutter/material.dart';
import 'color_palette.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorPalette.primaryColor,
    primaryColorDark: ColorPalette.primaryVariant,
    scaffoldBackgroundColor: ColorPalette.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPalette.primaryColor,
      primary: ColorPalette.primaryColor,
      onPrimary: ColorPalette.onPrimaryColor,
      secondary: ColorPalette.secondaryColor,
      onSecondary: ColorPalette.onSecondaryColor,
      surface: ColorPalette.backgroundColor,
      onSurface: ColorPalette.onBackgroundColor,
      error: ColorPalette.errorColor,
      onError: ColorPalette.onErrorColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyles.headline1,
      headlineMedium: TextStyles.headline2,
      bodyLarge: TextStyles.bodyText1,
      bodyMedium: TextStyles.bodyText2,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorPalette.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.backgroundColor,
      foregroundColor: ColorPalette.onBackgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ColorPalette.onBackgroundColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: ColorPalette.onBackgroundColor,
        size: 24.0,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorPalette.onBackgroundColor,
      size: 24.0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.primaryColor,
      foregroundColor: ColorPalette.onPrimaryColor,
      elevation: 6.0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: ColorPalette.primaryColor,
    primaryColorDark: ColorPalette.primaryVariant,
    scaffoldBackgroundColor: ColorPalette.darkBackgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorPalette.primaryColor,
      primary: ColorPalette.primaryColor,
      onPrimary: ColorPalette.onPrimaryColor,
      secondary: ColorPalette.secondaryColor,
      onSecondary: ColorPalette.onSecondaryColor,
      surface: ColorPalette.darkBackgroundColor,
      onSurface: ColorPalette.onDarkBackgroundColor,
      error: ColorPalette.errorColor,
      onError: ColorPalette.onErrorColor,
      brightness: Brightness.dark,
    ),
    cardColor: const Color.fromRGBO(45, 47, 60, 1),
    textTheme: TextTheme(
      headlineLarge: TextStyles.headline1.copyWith(
        color: ColorPalette.onDarkBackgroundColor,
      ),
      headlineMedium: TextStyles.headline2.copyWith(
        color: ColorPalette.onDarkBackgroundColor,
      ),
      bodyLarge: TextStyles.bodyText1.copyWith(
        color: ColorPalette.onDarkBackgroundColor,
      ),
      bodyMedium: TextStyles.bodyText2.copyWith(
        color: ColorPalette.onDarkBackgroundColor,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorPalette.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorPalette.darkBackgroundColor,
      foregroundColor: ColorPalette.onDarkBackgroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ColorPalette.onDarkBackgroundColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: ColorPalette.onDarkBackgroundColor,
        size: 24.0,
      ),
    ),
    iconTheme: const IconThemeData(
      color: ColorPalette.onDarkBackgroundColor,
      size: 24.0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.primaryColor,
      foregroundColor: ColorPalette.onPrimaryColor,
      elevation: 6.0,
    ),
  );
}
