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
      capital: (json['capital'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      region: json['region'] as String,
      subregion: json['subregion'] as String?,
      area: (json['area'] as num).toDouble(),
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
  'capital': instance.capital,
  'region': instance.region,
  'subregion': instance.subregion,
  'area': instance.area,
  'timezones': instance.timezones,
};
