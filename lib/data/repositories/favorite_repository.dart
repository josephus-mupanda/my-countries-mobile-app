import 'package:countries_app/core/utils/preferences.dart';
import '../models/favorites_model.dart';

class FavoritesRepository {

  Future<List<FavoriteCountry>> getFavorites() async {
    return Preferences.getFavorites();
  }

  Future<void> saveFavorites(List<FavoriteCountry> favorites) async {
    await Preferences.saveFavorites(favorites);
  }

  Future<void> clearFavorites() async {
    await Preferences.saveFavorites([]);
  }
}
