import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:countries_app/data/models/favorites_model.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.loaded(List<FavoriteCountry> favorites) = _Loaded;
  const factory FavoritesState.empty() = _Empty;
  const factory FavoritesState.error(String message) = _Error;
}