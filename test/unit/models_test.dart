import 'package:flutter_test/flutter_test.dart';
import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/data/models/country_details.dart';
import 'package:countries_app/data/models/favorites_model.dart';

void main() {
  group('CountrySummary Model Tests', () {
    test('should create CountrySummary from JSON', () {
      final json = {
        'name': {'common': 'Ethiopia'},
        'flags': {'png': 'https://flagcdn.com/w320/et.png'},
        'population': 123456789,
        'cca2': 'ET',
      };

      final country = CountrySummary.fromJson(json);

      expect(country.commonName, 'Ethiopia');
      expect(country.flagUrl, 'https://flagcdn.com/w320/et.png');
      expect(country.population, 123456789);
      expect(country.cca2, 'ET');
    });

    test('should handle missing common name gracefully', () {
      final json = {
        'name': {},
        'flags': {'png': 'https://flagcdn.com/w320/et.png'},
        'population': 123456789,
        'cca2': 'ET',
      };

      final country = CountrySummary.fromJson(json);

      expect(country.commonName, '');
    });

    test('should handle missing flag URL gracefully', () {
      final json = {
        'name': {'common': 'Ethiopia'},
        'flags': {},
        'population': 123456789,
        'cca2': 'ET',
      };

      final country = CountrySummary.fromJson(json);

      expect(country.flagUrl, '');
    });

    test('should serialize to JSON correctly', () {
      final country = CountrySummary(
        name: {'common': 'Ethiopia'},
        flags: {'png': 'https://flagcdn.com/w320/et.png'},
        population: 123456789,
        cca2: 'ET',
      );

      final json = country.toJson();

      expect(json['name']['common'], 'Ethiopia');
      expect(json['flags']['png'], 'https://flagcdn.com/w320/et.png');
      expect(json['population'], 123456789);
      expect(json['cca2'], 'ET');
    });
  });

  group('CountryDetails Model Tests', () {
    test('should create CountryDetails from JSON', () {
      final json = {
        'name': {'common': 'Ethiopia'},
        'flags': {'png': 'https://flagcdn.com/w320/et.png'},
        'population': 123456789,
        'area': 1104300.0,
        'region': 'Africa',
        'subregion': 'Eastern Africa',
        'capital': ['Addis Ababa'],
        'timezones': ['UTC+03:00'],
      };

      final details = CountryDetails.fromJson(json);

      expect(details.commonName, 'Ethiopia');
      expect(details.flagUrl, 'https://flagcdn.com/w320/et.png');
      expect(details.population, 123456789);
      expect(details.area, 1104300.0);
      expect(details.region, 'Africa');
      expect(details.subregion, 'Eastern Africa');
      expect(details.capitalName, 'Addis Ababa');
      expect(details.timezones, ['UTC+03:00']);
    });

    test('should handle empty capital array', () {
      final json = {
        'name': {'common': 'Ethiopia'},
        'flags': {'png': 'https://flagcdn.com/w320/et.png'},
        'population': 123456789,
        'area': 1104300.0,
        'region': 'Africa',
        'timezones': ['UTC+03:00'],
      };

      final details = CountryDetails.fromJson(json);

      expect(details.capital, isNull);
      expect(details.capitalName, '');
    });

    test('should serialize to JSON correctly', () {
      final details = CountryDetails(
        name: {'common': 'Ethiopia'},
        flags: {'png': 'https://flagcdn.com/w320/et.png'},
        population: 123456789,
        area: 1104300.0,
        region: 'Africa',
        subregion: 'Eastern Africa',
        capital: ['Addis Ababa'],
        timezones: ['UTC+03:00'],
      );

      final json = details.toJson();

      expect(json['name']['common'], 'Ethiopia');
      expect(json['flags']['png'], 'https://flagcdn.com/w320/et.png');
      expect(json['population'], 123456789);
      expect(json['area'], 1104300.0);
      expect(json['region'], 'Africa');
      expect(json['subregion'], 'Eastern Africa');
      expect(json['capital'], ['Addis Ababa']);
      expect(json['timezones'], ['UTC+03:00']);
    });
  });

  group('FavoriteCountry Model Tests', () {
    test('should create FavoriteCountry from JSON', () {
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

    test('should serialize to JSON correctly', () {
      final favorite = FavoriteCountry(
        cca2: 'ET',
        name: 'Ethiopia',
        capital: 'Addis Ababa',
        flagUrl: 'https://flagcdn.com/w320/et.png',
      );

      final json = favorite.toJson();

      expect(json['cca2'], 'ET');
      expect(json['name'], 'Ethiopia');
      expect(json['capital'], 'Addis Ababa');
      expect(json['flagUrl'], 'https://flagcdn.com/w320/et.png');
    });

    test('should create FavoriteCountry from CountrySummary', () {
      final country = CountrySummary(
        name: {'common': 'Ethiopia'},
        flags: {'png': 'https://flagcdn.com/w320/et.png'},
        population: 123456789,
        cca2: 'ET',
      );

      final favorite = FavoriteCountry(
        cca2: country.cca2,
        name: country.commonName,
        capital: '',
        flagUrl: country.flagUrl,
      );

      expect(favorite.cca2, 'ET');
      expect(favorite.name, 'Ethiopia');
      expect(favorite.capital, '');
      expect(favorite.flagUrl, 'https://flagcdn.com/w320/et.png');
    });
  });
}