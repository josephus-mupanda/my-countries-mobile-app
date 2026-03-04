// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FavoriteCountry _$FavoriteCountryFromJson(Map<String, dynamic> json) {
  return _FavoriteCountry.fromJson(json);
}

/// @nodoc
mixin _$FavoriteCountry {
  String get cca2 => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get capital => throw _privateConstructorUsedError;
  String get flagUrl => throw _privateConstructorUsedError;

  /// Serializes this FavoriteCountry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteCountry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteCountryCopyWith<FavoriteCountry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteCountryCopyWith<$Res> {
  factory $FavoriteCountryCopyWith(
    FavoriteCountry value,
    $Res Function(FavoriteCountry) then,
  ) = _$FavoriteCountryCopyWithImpl<$Res, FavoriteCountry>;
  @useResult
  $Res call({String cca2, String name, String capital, String flagUrl});
}

/// @nodoc
class _$FavoriteCountryCopyWithImpl<$Res, $Val extends FavoriteCountry>
    implements $FavoriteCountryCopyWith<$Res> {
  _$FavoriteCountryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteCountry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cca2 = null,
    Object? name = null,
    Object? capital = null,
    Object? flagUrl = null,
  }) {
    return _then(
      _value.copyWith(
            cca2: null == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            capital: null == capital
                ? _value.capital
                : capital // ignore: cast_nullable_to_non_nullable
                      as String,
            flagUrl: null == flagUrl
                ? _value.flagUrl
                : flagUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FavoriteCountryImplCopyWith<$Res>
    implements $FavoriteCountryCopyWith<$Res> {
  factory _$$FavoriteCountryImplCopyWith(
    _$FavoriteCountryImpl value,
    $Res Function(_$FavoriteCountryImpl) then,
  ) = __$$FavoriteCountryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cca2, String name, String capital, String flagUrl});
}

/// @nodoc
class __$$FavoriteCountryImplCopyWithImpl<$Res>
    extends _$FavoriteCountryCopyWithImpl<$Res, _$FavoriteCountryImpl>
    implements _$$FavoriteCountryImplCopyWith<$Res> {
  __$$FavoriteCountryImplCopyWithImpl(
    _$FavoriteCountryImpl _value,
    $Res Function(_$FavoriteCountryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoriteCountry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cca2 = null,
    Object? name = null,
    Object? capital = null,
    Object? flagUrl = null,
  }) {
    return _then(
      _$FavoriteCountryImpl(
        cca2: null == cca2
            ? _value.cca2
            : cca2 // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        capital: null == capital
            ? _value.capital
            : capital // ignore: cast_nullable_to_non_nullable
                  as String,
        flagUrl: null == flagUrl
            ? _value.flagUrl
            : flagUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteCountryImpl implements _FavoriteCountry {
  const _$FavoriteCountryImpl({
    required this.cca2,
    required this.name,
    required this.capital,
    required this.flagUrl,
  });

  factory _$FavoriteCountryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteCountryImplFromJson(json);

  @override
  final String cca2;
  @override
  final String name;
  @override
  final String capital;
  @override
  final String flagUrl;

  @override
  String toString() {
    return 'FavoriteCountry(cca2: $cca2, name: $name, capital: $capital, flagUrl: $flagUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteCountryImpl &&
            (identical(other.cca2, cca2) || other.cca2 == cca2) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.capital, capital) || other.capital == capital) &&
            (identical(other.flagUrl, flagUrl) || other.flagUrl == flagUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, cca2, name, capital, flagUrl);

  /// Create a copy of FavoriteCountry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteCountryImplCopyWith<_$FavoriteCountryImpl> get copyWith =>
      __$$FavoriteCountryImplCopyWithImpl<_$FavoriteCountryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteCountryImplToJson(this);
  }
}

abstract class _FavoriteCountry implements FavoriteCountry {
  const factory _FavoriteCountry({
    required final String cca2,
    required final String name,
    required final String capital,
    required final String flagUrl,
  }) = _$FavoriteCountryImpl;

  factory _FavoriteCountry.fromJson(Map<String, dynamic> json) =
      _$FavoriteCountryImpl.fromJson;

  @override
  String get cca2;
  @override
  String get name;
  @override
  String get capital;
  @override
  String get flagUrl;

  /// Create a copy of FavoriteCountry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteCountryImplCopyWith<_$FavoriteCountryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
