import 'package:countries_app/data/repositories/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../core/utils/preferences.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository) : super(const FavoritesState.loaded([])) {
    on<_LoadFavorites>((event, emit) async {
      final favorites = Preferences.getFavorites();
      emit(FavoritesState.loaded(favorites));
    });

    on<_ToggleFavorite>((event, emit) async {
      final current = state.maybeWhen(
        loaded: (list) => List<FavoriteCountry>.from(list),
        orElse: () => [],
      );

      if (current.any((c) => c.cca2 == event.country.cca2)) {
        current.removeWhere((c) => c.cca2 == event.country.cca2);
      } else {
        current.add(event.country);
      }

      await Preferences.saveFavorites(current);
      emit(FavoritesState.loaded(current));
    });
  }
}