// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CountryDetailsEvent {
  String get cca2 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cca2) fetchDetails,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cca2)? fetchDetails,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cca2)? fetchDetails,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDetails value) fetchDetails,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDetails value)? fetchDetails,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDetails value)? fetchDetails,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of CountryDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CountryDetailsEventCopyWith<CountryDetailsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryDetailsEventCopyWith<$Res> {
  factory $CountryDetailsEventCopyWith(
    CountryDetailsEvent value,
    $Res Function(CountryDetailsEvent) then,
  ) = _$CountryDetailsEventCopyWithImpl<$Res, CountryDetailsEvent>;
  @useResult
  $Res call({String cca2});
}

/// @nodoc
class _$CountryDetailsEventCopyWithImpl<$Res, $Val extends CountryDetailsEvent>
    implements $CountryDetailsEventCopyWith<$Res> {
  _$CountryDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CountryDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cca2 = null}) {
    return _then(
      _value.copyWith(
            cca2: null == cca2
                ? _value.cca2
                : cca2 // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FetchDetailsImplCopyWith<$Res>
    implements $CountryDetailsEventCopyWith<$Res> {
  factory _$$FetchDetailsImplCopyWith(
    _$FetchDetailsImpl value,
    $Res Function(_$FetchDetailsImpl) then,
  ) = __$$FetchDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cca2});
}

/// @nodoc
class __$$FetchDetailsImplCopyWithImpl<$Res>
    extends _$CountryDetailsEventCopyWithImpl<$Res, _$FetchDetailsImpl>
    implements _$$FetchDetailsImplCopyWith<$Res> {
  __$$FetchDetailsImplCopyWithImpl(
    _$FetchDetailsImpl _value,
    $Res Function(_$FetchDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CountryDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cca2 = null}) {
    return _then(
      _$FetchDetailsImpl(
        null == cca2
            ? _value.cca2
            : cca2 // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FetchDetailsImpl implements _FetchDetails {
  const _$FetchDetailsImpl(this.cca2);

  @override
  final String cca2;

  @override
  String toString() {
    return 'CountryDetailsEvent.fetchDetails(cca2: $cca2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchDetailsImpl &&
            (identical(other.cca2, cca2) || other.cca2 == cca2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cca2);

  /// Create a copy of CountryDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchDetailsImplCopyWith<_$FetchDetailsImpl> get copyWith =>
      __$$FetchDetailsImplCopyWithImpl<_$FetchDetailsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cca2) fetchDetails,
  }) {
    return fetchDetails(cca2);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cca2)? fetchDetails,
  }) {
    return fetchDetails?.call(cca2);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cca2)? fetchDetails,
    required TResult orElse(),
  }) {
    if (fetchDetails != null) {
      return fetchDetails(cca2);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDetails value) fetchDetails,
  }) {
    return fetchDetails(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDetails value)? fetchDetails,
  }) {
    return fetchDetails?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDetails value)? fetchDetails,
    required TResult orElse(),
  }) {
    if (fetchDetails != null) {
      return fetchDetails(this);
    }
    return orElse();
  }
}

abstract class _FetchDetails implements CountryDetailsEvent {
  const factory _FetchDetails(final String cca2) = _$FetchDetailsImpl;

  @override
  String get cca2;

  /// Create a copy of CountryDetailsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchDetailsImplCopyWith<_$FetchDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
