// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FavoritesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFavorites,
    required TResult Function(FavoriteCountry country) toggleFavorite,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFavorites,
    TResult? Function(FavoriteCountry country)? toggleFavorite,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFavorites,
    TResult Function(FavoriteCountry country)? toggleFavorite,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFavorites value) loadFavorites,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFavorites value)? loadFavorites,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFavorites value)? loadFavorites,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesEventCopyWith<$Res> {
  factory $FavoritesEventCopyWith(
    FavoritesEvent value,
    $Res Function(FavoritesEvent) then,
  ) = _$FavoritesEventCopyWithImpl<$Res, FavoritesEvent>;
}

/// @nodoc
class _$FavoritesEventCopyWithImpl<$Res, $Val extends FavoritesEvent>
    implements $FavoritesEventCopyWith<$Res> {
  _$FavoritesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadFavoritesImplCopyWith<$Res> {
  factory _$$LoadFavoritesImplCopyWith(
    _$LoadFavoritesImpl value,
    $Res Function(_$LoadFavoritesImpl) then,
  ) = __$$LoadFavoritesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$LoadFavoritesImpl>
    implements _$$LoadFavoritesImplCopyWith<$Res> {
  __$$LoadFavoritesImplCopyWithImpl(
    _$LoadFavoritesImpl _value,
    $Res Function(_$LoadFavoritesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadFavoritesImpl implements _LoadFavorites {
  const _$LoadFavoritesImpl();

  @override
  String toString() {
    return 'FavoritesEvent.loadFavorites()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadFavoritesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFavorites,
    required TResult Function(FavoriteCountry country) toggleFavorite,
  }) {
    return loadFavorites();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFavorites,
    TResult? Function(FavoriteCountry country)? toggleFavorite,
  }) {
    return loadFavorites?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFavorites,
    TResult Function(FavoriteCountry country)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (loadFavorites != null) {
      return loadFavorites();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFavorites value) loadFavorites,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
  }) {
    return loadFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFavorites value)? loadFavorites,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
  }) {
    return loadFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFavorites value)? loadFavorites,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (loadFavorites != null) {
      return loadFavorites(this);
    }
    return orElse();
  }
}

abstract class _LoadFavorites implements FavoritesEvent {
  const factory _LoadFavorites() = _$LoadFavoritesImpl;
}

/// @nodoc
abstract class _$$ToggleFavoriteImplCopyWith<$Res> {
  factory _$$ToggleFavoriteImplCopyWith(
    _$ToggleFavoriteImpl value,
    $Res Function(_$ToggleFavoriteImpl) then,
  ) = __$$ToggleFavoriteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FavoriteCountry country});

  $FavoriteCountryCopyWith<$Res> get country;
}

/// @nodoc
class __$$ToggleFavoriteImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$ToggleFavoriteImpl>
    implements _$$ToggleFavoriteImplCopyWith<$Res> {
  __$$ToggleFavoriteImplCopyWithImpl(
    _$ToggleFavoriteImpl _value,
    $Res Function(_$ToggleFavoriteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? country = null}) {
    return _then(
      _$ToggleFavoriteImpl(
        null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as FavoriteCountry,
      ),
    );
  }

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FavoriteCountryCopyWith<$Res> get country {
    return $FavoriteCountryCopyWith<$Res>(_value.country, (value) {
      return _then(_value.copyWith(country: value));
    });
  }
}

/// @nodoc

class _$ToggleFavoriteImpl implements _ToggleFavorite {
  const _$ToggleFavoriteImpl(this.country);

  @override
  final FavoriteCountry country;

  @override
  String toString() {
    return 'FavoritesEvent.toggleFavorite(country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleFavoriteImpl &&
            (identical(other.country, country) || other.country == country));
  }

  @override
  int get hashCode => Object.hash(runtimeType, country);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      __$$ToggleFavoriteImplCopyWithImpl<_$ToggleFavoriteImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadFavorites,
    required TResult Function(FavoriteCountry country) toggleFavorite,
  }) {
    return toggleFavorite(country);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadFavorites,
    TResult? Function(FavoriteCountry country)? toggleFavorite,
  }) {
    return toggleFavorite?.call(country);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadFavorites,
    TResult Function(FavoriteCountry country)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(country);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadFavorites value) loadFavorites,
    required TResult Function(_ToggleFavorite value) toggleFavorite,
  }) {
    return toggleFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadFavorites value)? loadFavorites,
    TResult? Function(_ToggleFavorite value)? toggleFavorite,
  }) {
    return toggleFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadFavorites value)? loadFavorites,
    TResult Function(_ToggleFavorite value)? toggleFavorite,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(this);
    }
    return orElse();
  }
}

abstract class _ToggleFavorite implements FavoritesEvent {
  const factory _ToggleFavorite(final FavoriteCountry country) =
      _$ToggleFavoriteImpl;

  FavoriteCountry get country;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
