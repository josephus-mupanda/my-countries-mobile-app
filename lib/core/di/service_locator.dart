// lib/core/di/service_locator.dart
import 'package:countries_app/core/api/dio_client.dart';
import 'package:get_it/get_it.dart';

// import '../network/dio_client.dart';
// import '../../data/repositories/country_repository.dart';
// import '../../logic/bloc/countries/countries_bloc.dart';
// import '../../logic/bloc/country_details/country_details_bloc.dart';
// import '../../logic/bloc/favorites/favorites_bloc.dart';

final GetIt sl = GetIt.instance;

/// Call this from main() before runApp():
///  await initServiceLocator();
/// Then also call:
///  await DioClient().initDiskCache();
Future<void> initServiceLocator() async {
  // Network
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // // Repositories
  // sl.registerLazySingleton<CountryRepository>(() => CountryRepository(sl<DioClient>()));

  // // BLoCs (register factories so each UI route can get a fresh instance)
  // sl.registerFactory(() => CountriesBloc(sl<CountryRepository>()));
  // sl.registerFactory(() => CountryDetailsBloc(sl<CountryRepository>()));
  // sl.registerFactory(() => FavoritesBloc(sl<CountryRepository>()));

  // // Any additional services (e.g., Preferences) are initialized in main() by the user.
}
