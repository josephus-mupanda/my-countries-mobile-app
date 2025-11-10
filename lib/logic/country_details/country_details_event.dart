import 'package:equatable/equatable.dart';

abstract class CountryDetailsEvent extends Equatable {
  const CountryDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchCountryDetails extends CountryDetailsEvent {
  final String code;

  const FetchCountryDetails(this.code);

  @override
  List<Object?> get props => [code];
}
