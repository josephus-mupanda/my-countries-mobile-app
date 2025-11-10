import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/api/api_exceptions.dart';
import '../../core/di/service_locator.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final CountryRepository _repository = sl<CountryRepository>();

  CountryListBloc() : super(CountryListInitial()) {
    on<FetchCountries>((event, emit) async {
      emit(CountryListLoading());
      try {
        final countries = await _repository.fetchAllCountries();
        emit(CountryListLoaded(countries));
      } on ApiException catch (e) {
        emit(CountryListError(e.message));
      } catch (e) {
        emit(CountryListError('Something went wrong'));
      }
    });
  }
}
