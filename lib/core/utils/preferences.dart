import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  // Keys for the preferences
  static const _keyIsFavorite = 'favorite_countries';
  static const _keyTheme = 'isDarkTheme';

  // Initialize SharedPreferences
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setIsFavorite(bool isLoggedIn) async {
    await _preferences?.setBool(_keyIsFavorite, isLoggedIn);
  }

  static bool? getIsFavorite() {
    return _preferences?.getBool(_keyIsFavorite);
  }


  static Future setIsDarkTheme(bool isDarkTheme) async {
    await _preferences?.setBool(_keyTheme, isDarkTheme);
  }

  static bool? getIsDarkTheme() {
    return _preferences?.getBool(_keyTheme);
  }

  static Future clear() async {
    await _preferences?.clear();
  }
}
