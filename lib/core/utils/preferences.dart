import 'dart:convert';
import 'package:countries_app/data/models/favorites_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  // Keys for the preferences
  static const _keyFavorites = 'favorite_countries';
  static const _keyTheme = 'isDarkTheme';

  // Initialize SharedPreferences
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

 static Future<void> saveFavorites(List<FavoriteCountry> favorites) async {
    final jsonString =
        json.encode(favorites.map((e) => e.toJson()).toList());
    await _preferences?.setString(_keyFavorites, jsonString);
  }

  static List<FavoriteCountry> getFavorites() {
    final jsonString = _preferences?.getString(_keyFavorites);
    if (jsonString == null) return [];
    final list = json.decode(jsonString) as List;
    return list.map((e) => FavoriteCountry.fromJson(e)).toList();
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
