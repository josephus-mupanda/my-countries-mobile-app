import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_details_event.dart';
import 'country_details_state.dart';
import '../../core/api/api_exceptions.dart';
import '../../core/di/service_locator.dart';

class CountryDetailsBloc extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  final CountryRepository _repository = sl<CountryRepository>();

  CountryDetailsBloc() : super(CountryDetailsInitial()) {
    on<FetchCountryDetails>((event, emit) async {
      emit(CountryDetailsLoading());
      try {
        final country = await _repository.fetchCountryDetails(event.code);
        emit(CountryDetailsLoaded(country));
      } on ApiException catch (e) {
        emit(CountryDetailsError(e.message));
      } catch (e) {
        emit(CountryDetailsError('Something went wrong'));
      }
    });
  }
}
