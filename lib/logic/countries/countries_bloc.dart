import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'countries_bloc.freezed.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountryRepository repository;

  CountriesBloc(this.repository) : super(const CountriesState.loading()) {
    on<_FetchAll>((event, emit) async {
      emit(const CountriesState.loading());
      try {
        final countries = await repository.fetchAllCountries();
        emit(CountriesState.loaded(countries));
      } catch (e) {
        emit(CountriesState.error(e.toString()));
      }
    });

    on<_Search>((event, emit) async {
      emit(const CountriesState.loading());
      try {
        final countries = await repository.searchCountries(event.query);
        emit(CountriesState.loaded(countries));
      } catch (e) {
        emit(CountriesState.error(e.toString()));
      }
    });
  }
}

