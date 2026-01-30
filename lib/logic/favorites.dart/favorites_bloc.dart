import 'package:countries_app/data/models/favorites_model.dart';
import 'package:countries_app/data/repositories/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository) : super(const FavoritesState.loaded([])) {
    on<FavoritesEvent>((event, emit) async {
      await event.map(
        loadFavorites: (e) async {
          final favorites = await repository.getFavorites();
          emit(FavoritesState.loaded(favorites));
        },
        toggleFavorite: (e) async {

          final current = state.maybeWhen(
            loaded: (list) => List<FavoriteCountry>.from(list),
            orElse: () => <FavoriteCountry>[], 
          );

          if (current.any((c) => c.cca2 == e.country.cca2)) {
            current.removeWhere((c) => c.cca2 == e.country.cca2);
          } else {
            current.add(e.country);
          }

          await repository.saveFavorites(current);
          emit(FavoritesState.loaded(current));
        },
      );
    });
  }
}