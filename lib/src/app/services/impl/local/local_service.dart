/*
    MIT License

    Copyright (c) 2020 Boris-Wilfried Nyasse
    [ https://gitlab.com/bwnyasse | https://github.com/bwnyasse ]

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/

import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String apiKey = 'api';
  static const String countryFlagKey = 'countryFlag';
  final  Future<SharedPreferences> _sharedPreferences;

  LocalStorageService({
    Future<SharedPreferences> sharedPreferences
  })  : _sharedPreferences = sharedPreferences ?? SharedPreferences.getInstance();

  List<Country> countries() =>
      CountryList.fromJson(_countriesAsJson()).countries;

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
    var value = (await _sharedPreferences).get(key);
    return value;
  }

  Future<void> _save(String key, String content) async {
    (await _sharedPreferences).setString(key, content);
  }


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
