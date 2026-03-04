import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/country_details/country_details_event.dart';
import 'package:countries_app/logic/favorites.dart/favorites_event.dart';
import 'package:countries_app/data/models/favorites_model.dart';

void setupTestFallbacks() {
  setUpAll(() {
    // Register fallback values for BLoC events
    registerFallbackValue(const CountriesEvent.fetchAll());
    registerFallbackValue(const CountriesEvent.search(''));
    registerFallbackValue(const CountryDetailsEvent.fetchDetails(''));
    registerFallbackValue(const FavoritesEvent.loadFavorites());
    registerFallbackValue(
      FavoritesEvent.toggleFavorite(
        FavoriteCountry(
          cca2: 'ET',
          name: 'Ethiopia',
          capital: 'Addis Ababa',
          flagUrl: 'https://flagcdn.com/w320/et.png',
        ),
      ),
    );
  });
}