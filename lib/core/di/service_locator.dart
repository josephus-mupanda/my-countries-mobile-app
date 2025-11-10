import 'package:countries_app/core/api/dio_client.dart';
import 'package:countries_app/data/repositories/country_repository.dart';
import 'package:countries_app/data/repositories/favorite_repository.dart';
import 'package:countries_app/logic/countries/countries_bloc.dart';
import 'package:countries_app/logic/country_details/country_details_bloc.dart';
import 'package:countries_app/logic/favorites.dart/favorites_bloc.dart';
import 'package:countries_app/logic/theme/theme_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;


Future<void> initServiceLocator() async {
  // ----------------------------
  // Services
  // ----------------------------
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ----------------------------
  // Repositories
  // ----------------------------
  sl.registerLazySingleton<CountryRepository>(() => CountryRepository(sl<DioClient>()));
  sl.registerLazySingleton<FavoritesRepository>(() => FavoritesRepository());

  // ----------------------------
  // Blocs / Cubits
  // ----------------------------

  // CountriesBloc depends on CountryRepository
  sl.registerFactory(() => CountriesBloc(sl<CountryRepository>()));

  // CountryDetailsBloc depends on CountryRepository
  sl.registerFactory(() => CountryDetailsBloc(sl<CountryRepository>()));

  // FavoritesBloc can optionally depend on FavoritesRepository
  sl.registerFactory(() => FavoritesBloc(sl<FavoritesRepository>()));

  // ThemeBloc does not depend on any repository directly, uses Preferences
  sl.registerFactory(() => ThemeBloc());
}
