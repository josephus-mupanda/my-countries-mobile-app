import 'package:countries_app/core/api/dio_client.dart';
import 'package:countries_app/core/config/app_config.dart';

import '../models/country_summary.dart';
import '../models/country_details.dart';


class CountryRepository {
  final DioClient dioClient;

  CountryRepository(this.dioClient);

  Future<List<CountrySummary>> fetchAllCountries() async {
    final response = await dioClient.get(
      '${AppConfig.apiBaseUrl}all?fields=name,flags,population,cca2',
    );
    return (response.data as List)
        .map((e) => CountrySummary.fromJson(e))
        .toList();
  }

  Future<List<CountrySummary>> searchCountries(String query) async {
    final response = await dioClient.get(
      '${AppConfig.apiBaseUrl}name/$query?fields=name,flags,population,cca2',
    );
    return (response.data as List)
        .map((e) => CountrySummary.fromJson(e))
        .toList();
  }

  Future<CountryDetails> getCountryDetails(String cca2) async {
    final response = await dioClient.get(
      '${AppConfig.apiBaseUrl}alpha/$cca2?fields=name,flags,population,capital,region,subregion,area,timezones',
    );

    final data = response.data is List 
        ? (response.data as List).first 
        : response.data;
    
    return CountryDetails.fromJson(data as Map<String, dynamic>);
  }
}

