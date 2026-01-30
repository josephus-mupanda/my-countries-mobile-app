import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/data/models/country_details.dart';
import 'package:countries_app/logic/countries/countries_bloc.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:countries_app/logic/country_details/country_details_bloc.dart';
import 'package:countries_app/logic/country_details/country_details_event.dart';
import 'package:countries_app/logic/country_details/country_details_state.dart';
import 'package:countries_app/data/repositories/country_repository.dart';
import '../helpers/test_setup.dart';

// Mock class implementing the repository interface
class MockCountryRepository extends Mock implements CountryRepository {}

void main() {
  setupTestFallbacks(); 
  
  late MockCountryRepository mockRepository;

  setUp(() {
    mockRepository = MockCountryRepository();
  });

  // ----------------- CountriesBloc Tests -----------------
  group('CountriesBloc', () {
    final mockCountries = [
      CountrySummary(
        name: {'common': 'Ethiopia'},
        flags: {'png': 'https://flagcdn.com/w320/et.png'},
        population: 123456789,
        cca2: 'ET',
      ),
      CountrySummary(
        name: {'common': 'Kenya'},
        flags: {'png': 'https://flagcdn.com/w320/ke.png'},
        population: 53771296,
        cca2: 'KE',
      ),
    ];

    blocTest<CountriesBloc, CountriesState>(
      'emits [loading, loaded] when fetchAll succeeds',
      build: () {
        when(() => mockRepository.fetchAllCountries())
            .thenAnswer((_) async => mockCountries);
        return CountriesBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const CountriesEvent.fetchAll()),
      expect: () => [
        const CountriesState.loading(),
        CountriesState.loaded(mockCountries),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchAllCountries()).called(1);
      },
    );

    blocTest<CountriesBloc, CountriesState>(
      'emits [loading, error] when fetchAll fails',
      build: () {
        when(() => mockRepository.fetchAllCountries())
            .thenThrow(Exception('Network error'));
        return CountriesBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const CountriesEvent.fetchAll()),
      expect: () => [
        const CountriesState.loading(),
        const CountriesState.error('Exception: Network error'),
      ],
      verify: (_) {
        verify(() => mockRepository.fetchAllCountries()).called(1);
      },
    );

    blocTest<CountriesBloc, CountriesState>(
      'emits [loading, loaded] when search succeeds',
      build: () {
        when(() => mockRepository.searchCountries('eth'))
            .thenAnswer((_) async => [mockCountries[0]]);
        return CountriesBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const CountriesEvent.search('eth')),
      expect: () => [
        const CountriesState.loading(),
        CountriesState.loaded([mockCountries[0]]),
      ],
      verify: (_) {
        verify(() => mockRepository.searchCountries('eth')).called(1);
      },
    );

    blocTest<CountriesBloc, CountriesState>(
      'emits [loading, error] when search fails',
      build: () {
        when(() => mockRepository.searchCountries('eth'))
            .thenThrow(Exception('Search failed'));
        return CountriesBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const CountriesEvent.search('eth')),
      expect: () => [
        const CountriesState.loading(),
        const CountriesState.error('Exception: Search failed'),
      ],
      verify: (_) {
        verify(() => mockRepository.searchCountries('eth')).called(1);
      },
    );
  });

  // ----------------- CountryDetailsBloc Tests -----------------
  group('CountryDetailsBloc', () {
    final mockDetails = CountryDetails(
      name: {'common': 'Ethiopia'},
      flags: {'png': 'https://flagcdn.com/w320/et.png'},
      population: 123456789,
      area: 1104300.0,
      region: 'Africa',
      subregion: 'Eastern Africa',
      capital: ['Addis Ababa'],
      timezones: ['UTC+03:00'],
    );

    blocTest<CountryDetailsBloc, CountryDetailsState>(
      'emits [loading, loaded] when fetchDetails succeeds',
      build: () {
        when(() => mockRepository.getCountryDetails('ET'))
            .thenAnswer((_) async => mockDetails);
        return CountryDetailsBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const CountryDetailsEvent.fetchDetails('ET')),
      expect: () => [
        const CountryDetailsState.loading(),
        CountryDetailsState.loaded(mockDetails),
      ],
      verify: (_) {
        verify(() => mockRepository.getCountryDetails('ET')).called(1);
      },
    );

    blocTest<CountryDetailsBloc, CountryDetailsState>(
      'emits [loading, error] when fetchDetails fails',
      build: () {
        when(() => mockRepository.getCountryDetails('ET'))
            .thenThrow(Exception('Details not found'));
        return CountryDetailsBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const CountryDetailsEvent.fetchDetails('ET')),
      expect: () => [
        const CountryDetailsState.loading(),
        const CountryDetailsState.error('Exception: Details not found'),
      ],
      verify: (_) {
        verify(() => mockRepository.getCountryDetails('ET')).called(1);
      },
    );
  });
}
