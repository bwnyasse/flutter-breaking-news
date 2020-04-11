import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String apiKey = 'api';
  static const String countryFlagKey = 'countryFlag';

  // API KEY
  Future<void> setApiKey(String keyValue) async =>
      await _save(apiKey, keyValue);

  Future<String> getApiKey() async => await _get(apiKey);

  // FLAG
  Future<String> getCountryFlag() async => await _get(countryFlagKey);

  Future<void> setCountryFlag(String keyValue) async =>
      await _save(countryFlagKey, keyValue);

  Future<LocalStorageData> getData() async {
    String a = await _get(apiKey);
    String c2 = await _get(countryFlagKey);
    return LocalStorageData(
      apiKey: a,
      countryFlag: c2,
    );
  }

  dynamic _get(String key) async {
    var value = (await SharedPreferences.getInstance()).get(key);
    return value;
  }

  Future<void> _save(String key, String content) async {
    (await SharedPreferences.getInstance()).setString(key, content);
  }

  List<Country> countries() =>
      CountryList.fromJson(_countriesAsJson()).countries;

  // Countries as JSON
  Map<String, dynamic> _countriesAsJson() => <String, dynamic>{
        "countries": [
          {"name": "Argentina", "flag": "ar"},
          {"name": "Australia", "flag": "au"},
          {"name": "Austria", "flag": "at"},
          {"name": "Belgium", "flag": "be"},
          {"name": "Brazil", "flag": "br"},
          {"name": "Bulgaria", "flag": "bg"},
          {"name": "Canada", "flag": "ca"},
          {"name": "China", "flag": "cn"},
          {"name": "Colombia", "flag": "co"},
          {"name": "Cuba", "flag": "cu"},
          {"name": "Czech Republic", "flag": "cz"},
          {"name": "Egypt", "flag": "eg"},
          {"name": "France", "flag": "fr"},
          {"name": "Germany", "flag": "de"},
          {"name": "Greece", "flag": "gr"},
          {"name": "Hong Kong", "flag": "hk"},
          {"name": "Hungary", "flag": "hu"},
          {"name": "India", "flag": "in"},
          {"name": "Indonesia", "flag": "id"},
          {"name": "Ireland", "flag": "ie"},
          {"name": "Israel", "flag": "il"},
          {"name": "Italy", "flag": "it"},
          {"name": "Japan", "flag": "jp"},
          {"name": "Latvia", "flag": "lv"},
          {"name": "Lithuania", "flag": "lt"},
          {"name": "Malaysia", "flag": "my"},
          {"name": "Mexico", "flag": "mx"},
          {"name": "Morocco", "flag": "ma"},
          {"name": "Netherlands", "flag": "nl"},
          {"name": "New Zealand", "flag": "nz"},
          {"name": "Nigeria", "flag": "ng"},
          {"name": "Norway", "flag": "no"},
          {"name": "Philippines", "flag": "ph"},
          {"name": "Poland", "flag": "pl"},
          {"name": "Portugal", "flag": "pt"},
          {"name": "Romania", "flag": "ro"},
          {"name": "Russia", "flag": "ru"},
          {"name": "Saudi Arabia", "flag": "sa"},
          {"name": "Serbia", "flag": "rs"},
          {"name": "Singapore", "flag": "sg"},
          {"name": "Slovakia", "flag": "sk"},
          {"name": "Slovenia", "flag": "si"},
          {"name": "South Africa", "flag": "za"},
          {"name": "South Korea", "flag": "kr"},
          {"name": "Sweden", "flag": "se"},
          {"name": "Switzerland", "flag": "ch"},
          {"name": "Taiwan", "flag": "tw"},
          {"name": "Thailand", "flag": "th"},
          {"name": "Turkey", "flag": "tr"},
          {"name": "UAE", "flag": "ae"},
          {"name": "Ukraine", "flag": "ua"},
          {"name": "United Kingdom", "flag": "gb"},
          {"name": "United States", "flag": "us"},
          {"name": "Venuzuela", "flag": "ve"}
        ]
      };
}
