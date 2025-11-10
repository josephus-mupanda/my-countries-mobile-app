import 'package:countries_app/core/utils/preferences.dart';
import '../models/favorites_model.dart';

class FavoritesRepository {

  /// Get all favorite countries
  Future<List<FavoriteCountry>> getFavorites() async {
    return Preferences.getFavorites();
  }

  /// Save the list of favorite countries
  Future<void> saveFavorites(List<FavoriteCountry> favorites) async {
    await Preferences.saveFavorites(favorites);
  }

  /// Clear all favorites
  Future<void> clearFavorites() async {
    await Preferences.saveFavorites([]);
  }

}
