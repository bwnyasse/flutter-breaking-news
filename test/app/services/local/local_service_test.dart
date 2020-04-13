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
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

main() {
  test('countries', () {
    MockSharedPreferences mock = MockSharedPreferences();
    expect(
        LocalStorageService(sharedPreferences: Future.value(mock))
            .countries()
            .length,
        equals(54));
  });

  test('getData', () async {
    MockSharedPreferences mock = MockSharedPreferences();
    when(mock.get('api')).thenReturn('some-api-value');
    when(mock.get('countryFlag')).thenReturn('some-countryFlag-value');
    LocalStorageData storageData =
        await LocalStorageService(sharedPreferences: Future.value(mock))
            .getData();
    expect(storageData.apiKey, equals("some-api-value"));
    expect(storageData.countryFlag, equals("some-countryFlag-value"));
  });

  test('setApiKey', () async {
    MockSharedPreferences mock = MockSharedPreferences();
    await LocalStorageService(sharedPreferences: Future.value(mock))
        .setApiKey('some-api-value');
    verify(mock.setString('api', 'some-api-value')); // OK: no arg matchers.

  });

  test('getApiKey', () async {
    SharedPreferences.setMockInitialValues({"api": "api-value"});
    expect(await LocalStorageService().getApiKey(), equals("api-value"));
  });


  test('getCountryFlag', () async {
    SharedPreferences.setMockInitialValues(
        {"countryFlag": "countryFlag-value"});
    expect(await LocalStorageService().getCountryFlag(),
        equals("countryFlag-value"));
  });

  test('setCountryFlag', () async {
    MockSharedPreferences mock = MockSharedPreferences();
    await LocalStorageService(sharedPreferences: Future.value(mock))
        .setCountryFlag('some-countryFlag-value');
    verify(mock.setString('countryFlag', 'some-countryFlag-value'));
  });
}
