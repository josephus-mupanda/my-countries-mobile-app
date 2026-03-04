import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:countries_app/data/models/country_summary.dart';

part 'countries_state.freezed.dart';

@freezed
class CountriesState with _$CountriesState {
  const factory CountriesState.loading() = _Loading;
  const factory CountriesState.loaded(List<CountrySummary> countries) = _Loaded;
  const factory CountriesState.error(String message) = _Error;
}