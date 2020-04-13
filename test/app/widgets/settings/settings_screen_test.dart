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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/providers/providers.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_settings/widgets/SettingsInputField.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

import '../../common.dart';

void main() {
  LocalStorageServiceMock localStorageServiceMock;
  AuthServiceMock authServiceMock;
  AuthBlocMock authBloc;
  MockClient mockClient;

  setUp(() {
    // Data & Api Service
    localStorageServiceMock = LocalStorageServiceMock();
    when(localStorageServiceMock.getApiKey())
        .thenAnswer((_) => Future.value('fake_key'));
    when(localStorageServiceMock.getCountryFlag())
        .thenAnswer((_) => Future.value('fake_country_flag'));
    mockClient = MockClient((request) async {
      return Response(json.encode(mockJsonResponse), 200);
    });
    // Auth & AuthBloc
    authServiceMock = AuthServiceMock();
    when(authServiceMock.signInWithGoogle())
        .thenAnswer((_) => Future.value(mockUser));
  });

  tearDown(() {
    authBloc?.close();
  });

  testWidgets('SettingsScreen', (WidgetTester tester) async {
    LocalStorageServiceMock localStorageServiceMock = LocalStorageServiceMock();
    when(localStorageServiceMock.countries())
        .thenReturn(CountryList.fromJson(mockCountriesAsJson()).countries);
    when(localStorageServiceMock.getData())
        .thenAnswer((_) => Future.value(mockLocalStorageData));

    await tester.pumpWidget(
      MaterialApp(
        home: AppProvider(
          httpClient: mockClient,
          localStorageService: localStorageServiceMock,
          authService: authServiceMock,
          child: SettingsScreen(),
        ),
      ),
    );
    // Auth Logout Button
    Finder screen = find.byType(SettingsScreen);
    expect(screen, findsOneWidget);

    await tester.tap(find.byType(SettingsInputField), pointer: 1);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  });
}
