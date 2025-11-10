import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final String countryCode;

  const AddFavorite(this.countryCode);

  @override
  List<Object?> get props => [countryCode];
}

class RemoveFavorite extends FavoritesEvent {
  final String countryCode;

  const RemoveFavorite(this.countryCode);

  @override
  List<Object?> get props => [countryCode];
}
