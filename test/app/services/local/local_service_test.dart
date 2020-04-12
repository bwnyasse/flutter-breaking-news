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
