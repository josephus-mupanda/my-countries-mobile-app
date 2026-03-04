import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'countries_event.dart'; 
import 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountryRepository repository;

  CountriesBloc(this.repository) : super(const CountriesState.loading()) {

     on<CountriesEvent>((event, emit) async {
      await event.map(
        fetchAll: (_) async {
          emit(const CountriesState.loading());
          try {
            final countries = await repository.fetchAllCountries();
            emit(CountriesState.loaded(countries));
          } catch (e) {
            emit(CountriesState.error(e.toString()));
          }
        },
        search: (e) async {
          emit(const CountriesState.loading());
          try {
            final countries = await repository.searchCountries(e.query);
            emit(CountriesState.loaded(countries));
          } catch (e) {
            emit(CountriesState.error(e.toString()));
          }
        },
      );
    });
  }
}

