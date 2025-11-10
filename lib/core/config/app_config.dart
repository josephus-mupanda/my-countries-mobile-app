import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://restcountries.com/v3.1/';
  static const Duration cacheDuration = Duration(days: 7);
  static const int searchDebounceMs = 400;
  static const String myFontFamily = 'Poppins';
}