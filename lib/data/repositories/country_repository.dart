import 'package:countries_app/core/api/dio_client.dart';

import '../models/country_summary.dart';
import '../models/country_details.dart';


class CountryRepository {
  final DioClient dioClient;

  CountryRepository(this.dioClient);

  Future<List<CountrySummary>> fetchAllCountries() async {
    final response = await dioClient.get(
      'https://restcountries.com/v3.1/all?fields=name,flags,population,cca2',
    );
    return (response.data as List)
        .map((e) => CountrySummary.fromJson(e))
        .toList();
  }

  Future<List<CountrySummary>> searchCountries(String query) async {
    final response = await dioClient.get(
      'https://restcountries.com/v3.1/name/$query?fields=name,flags,population,cca2',
    );
    return (response.data as List)
        .map((e) => CountrySummary.fromJson(e))
        .toList();
  }

  Future<CountryDetails> getCountryDetails(String cca2) async {
    final response = await dioClient.get(
      'https://restcountries.com/v3.1/alpha/$cca2?fields=name,flags,population,capital,region,subregion,area,timezones',
    );
    return CountryDetails.fromJson((response.data as List).first);
  }
}

