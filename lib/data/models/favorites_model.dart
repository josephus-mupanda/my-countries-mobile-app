import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_model.freezed.dart';
part 'favorites_model.g.dart';

@freezed
class FavoriteCountry with _$FavoriteCountry {
  const factory FavoriteCountry({
    required String cca2,
    required String name,
    required String capital,
    required String flagUrl,
  }) = _FavoriteCountry;

  factory FavoriteCountry.fromJson(Map<String, dynamic> json) =>
      _$FavoriteCountryFromJson(json);
}
