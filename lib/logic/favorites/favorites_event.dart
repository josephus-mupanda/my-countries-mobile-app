import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:countries_app/data/models/favorites_model.dart';

part 'favorites_event.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.loadFavorites() = _LoadFavorites;
  const factory FavoritesEvent.toggleFavorite(FavoriteCountry country) = _ToggleFavorite;
}