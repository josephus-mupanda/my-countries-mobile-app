import 'package:freezed_annotation/freezed_annotation.dart';

part 'countries_event.freezed.dart';


@freezed
class CountriesEvent with _$CountriesEvent {
  const factory CountriesEvent.fetchAll() = _FetchAll;
  const factory CountriesEvent.search(String query) = _Search;
}


