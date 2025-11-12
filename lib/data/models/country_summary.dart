import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_summary.freezed.dart';
part 'country_summary.g.dart';

@freezed
class CountrySummary with _$CountrySummary {
  const factory CountrySummary({
    required Map<String, dynamic> name,
    required Map<String, dynamic> flags,
    required int population,
    required String cca2,
  }) = _CountrySummary;

  factory CountrySummary.fromJson(Map<String, dynamic> json) =>
      _$CountrySummaryFromJson(json);
}

extension CountrySummaryExt on CountrySummary {
  String get commonName => name['common'] ?? '';
  String get flagUrl => flags['png'] ?? '';

}
