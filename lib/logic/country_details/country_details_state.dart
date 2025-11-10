import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:countries_app/data/models/country_details.dart';

part 'country_details_state.freezed.dart';

@freezed
class CountryDetailsState with _$CountryDetailsState {
  const factory CountryDetailsState.loading() = _Loading;
  const factory CountryDetailsState.loaded(CountryDetails country) = _Loaded;
  const factory CountryDetailsState.error(String message) = _Error;
}

