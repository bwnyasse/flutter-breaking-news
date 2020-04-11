// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    json['name'] as String,
    json['flag'] as String,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'flag': instance.flag,
    };

CountryList _$CountryListFromJson(Map<String, dynamic> json) {
  return CountryList(
    (json['countries'] as List)
        ?.map((e) =>
            e == null ? null : Country.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CountryListToJson(CountryList instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };
