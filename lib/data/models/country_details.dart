import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_details.freezed.dart';
part 'country_details.g.dart';

@freezed
class CountryDetails with _$CountryDetails {
  
  const factory CountryDetails({
    required Map<String, dynamic> name,
    required Map<String, dynamic> flags,
    required int population,
    required double area,
    required String region,
    List<String>? capital,
    String? subregion,
    required List<String> timezones,
  }) = _CountryDetails;

  factory CountryDetails.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailsFromJson(json);
}

extension CountryDetailsExt on CountryDetails {
  String get commonName => name['common'] ?? '';
  String get flagUrl => flags['png'] ?? '';
  String get capitalName => capital?.isNotEmpty == true ? capital![0] : '';
}
