// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryDetailsImpl _$$CountryDetailsImplFromJson(Map<String, dynamic> json) =>
    _$CountryDetailsImpl(
      name: json['name'] as Map<String, dynamic>,
      flags: json['flags'] as Map<String, dynamic>,
      population: (json['population'] as num).toInt(),
      area: (json['area'] as num).toDouble(),
      region: json['region'] as String,
      capital: (json['capital'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subregion: json['subregion'] as String?,
      timezones: (json['timezones'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CountryDetailsImplToJson(
  _$CountryDetailsImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'flags': instance.flags,
  'population': instance.population,
  'area': instance.area,
  'region': instance.region,
  'capital': instance.capital,
  'subregion': instance.subregion,
  'timezones': instance.timezones,
};
