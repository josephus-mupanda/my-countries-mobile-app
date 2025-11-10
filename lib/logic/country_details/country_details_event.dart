import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_details_event.freezed.dart';

@freezed
class CountryDetailsEvent with _$CountryDetailsEvent {
  const factory CountryDetailsEvent.fetchDetails(String cca2) = _FetchDetails;
}