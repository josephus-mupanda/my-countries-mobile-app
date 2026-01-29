import 'package:flutter_test/flutter_test.dart';
import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/data/models/country_details.dart';
import 'package:countries_app/data/models/favorites_model.dart';
import 'mock_data.dart';

void main() {
  group('MockData', () {
    test('should return mock countries', () {
      final countries = MockData.mockCountries;
      
      expect(countries, isNotEmpty);
      expect(countries.length, 3);
      expect(countries[0].commonName, 'Ethiopia');
      expect(countries[0].cca2, 'ET');
    });

    test('should return mock country details', () {
      final details = MockData.mockCountryDetails;
      
      expect(details.commonName, 'Ethiopia');
      expect(details.region, 'Africa');
      expect(details.capitalName, 'Addis Ababa');
      expect(details.timezones, ['UTC+03:00']);
    });

    test('should return mock favorites', () {
      final favorites = MockData.mockFavorites;
      
      expect(favorites, isNotEmpty);
      expect(favorites.length, 2);
      expect(favorites[0].name, 'Ethiopia');
      expect(favorites[0].cca2, 'ET');
      expect(favorites[1].name, 'Kenya');
    });

    test('CountrySummary extension methods work correctly', () {
      final country = MockData.mockCountries[0];
      
      expect(country.commonName, 'Ethiopia');
      expect(country.flagUrl, 'https://flagcdn.com/w320/et.png');
    });

    test('CountryDetails extension methods work correctly', () {
      final details = MockData.mockCountryDetails;
      
      expect(details.commonName, 'Ethiopia');
      expect(details.flagUrl, 'https://flagcdn.com/w320/et.png');
      expect(details.capitalName, 'Addis Ababa');
    });

    test('FavoriteCountry can be created from JSON', () {
      final json = {
        'cca2': 'ET',
        'name': 'Ethiopia',
        'capital': 'Addis Ababa',
        'flagUrl': 'https://flagcdn.com/w320/et.png',
      };
      
      final favorite = FavoriteCountry.fromJson(json);
      
      expect(favorite.cca2, 'ET');
      expect(favorite.name, 'Ethiopia');
      expect(favorite.capital, 'Addis Ababa');
      expect(favorite.flagUrl, 'https://flagcdn.com/w320/et.png');
    });
  });
}