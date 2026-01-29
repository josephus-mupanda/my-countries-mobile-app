import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/data/models/country_details.dart';
import 'package:countries_app/data/models/favorites_model.dart';

class MockData {
  static List<CountrySummary> get mockCountries => [
        CountrySummary(
          name: {'common': 'Ethiopia'},
          flags: {'png': 'https://flagcdn.com/w320/et.png'},
          population: 123456789,
          cca2: 'ET',
        ),
        CountrySummary(
          name: {'common': 'Kenya'},
          flags: {'png': 'https://flagcdn.com/w320/ke.png'},
          population: 53771296,
          cca2: 'KE',
        ),
        CountrySummary(
          name: {'common': 'Nigeria'},
          flags: {'png': 'https://flagcdn.com/w320/ng.png'},
          population: 218126212,
          cca2: 'NG',
        ),
      ];

  static CountryDetails get mockCountryDetails => CountryDetails(
        name: {'common': 'Ethiopia'},
        flags: {'png': 'https://flagcdn.com/w320/et.png'},
        population: 123456789,
        area: 1104300.0,
        region: 'Africa',
        subregion: 'Eastern Africa',
        capital: ['Addis Ababa'],
        timezones: ['UTC+03:00'],
      );

  static List<FavoriteCountry> get mockFavorites => [
        FavoriteCountry(
          cca2: 'ET',
          name: 'Ethiopia',
          capital: 'Addis Ababa',
          flagUrl: 'https://flagcdn.com/w320/et.png',
        ),
        FavoriteCountry(
          cca2: 'KE',
          name: 'Kenya',
          capital: 'Nairobi',
          flagUrl: 'https://flagcdn.com/w320/ke.png',
        ),
      ];
}