import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../core/utils/preferences.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final codes = <String>[];
        final stored = Preferences.getIsFavorite();
        if (stored == true) {
          // Assuming you will store favorite codes as a List<String> later
          // For now, if it is just bool, you may adjust
        }
        emit(FavoritesLoaded(codes));
      } catch (e) {
        emit(FavoritesError('Failed to load favorites'));
      }
    });

    on<AddFavorite>((event, emit) async {
      if (state is FavoritesLoaded) {
        final current = List<String>.from((state as FavoritesLoaded).favoriteCodes);
        if (!current.contains(event.countryCode)) {
          current.add(event.countryCode);
          await Preferences.setIsFavorite(true); // or save actual list
          emit(FavoritesLoaded(current));
        }
      }
    });

    on<RemoveFavorite>((event, emit) async {
      if (state is FavoritesLoaded) {
        final current = List<String>.from((state as FavoritesLoaded).favoriteCodes);
        current.remove(event.countryCode);
        await Preferences.setIsFavorite(false); // or save actual list
        emit(FavoritesLoaded(current));
      }
    });
  }
}
