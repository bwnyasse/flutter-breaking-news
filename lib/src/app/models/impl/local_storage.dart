import 'package:json_annotation/json_annotation.dart';

part 'local_storage.g.dart';

@JsonSerializable()
class Country {
  final String name;
  final String flag;

  Country(this.name, this.flag);

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class CountryList {
  final List<Country> countries;

  CountryList(this.countries);

  factory CountryList.fromJson(Map<String, dynamic> json) =>
      _$CountryListFromJson(json);

  Map<String, dynamic> toJson() => _$CountryListToJson(this);
}

class LocalStorageData {
  final String countryFlag;
  final String apiKey;

  LocalStorageData({this.countryFlag, this.apiKey});
}
