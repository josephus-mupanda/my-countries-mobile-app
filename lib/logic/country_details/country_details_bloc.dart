import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_details_event.dart';
import 'country_details_state.dart';

class CountryDetailsBloc extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  
  final CountryRepository repository;

  CountryDetailsBloc(this.repository) : super(const CountryDetailsState.loading()) {
    on<CountryDetailsEvent>((event, emit) async {
      await event.map(
        fetchDetails: (e) async {
          emit(const CountryDetailsState.loading());
          try {
            final details = await repository.getCountryDetails(e.cca2);
            emit(CountryDetailsState.loaded(details));
          } catch (err) {
            emit(CountryDetailsState.error(err.toString()));
          }
        },
      );
    });
  }
}

