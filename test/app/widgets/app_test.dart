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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/impl/user.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/providers/providers.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_settings/widgets/SettingsInputField.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../common.dart';

LocalStorageData mockLocalStorageData = LocalStorageData(
  countryFlag: 'ar',
  apiKey: 'some-api-key',
);

Map<String, dynamic> mockCountriesAsJson() => <String, dynamic>{
      "countries": [
        {"name": "Argentine", "flag": "ar"},
      ]
    };

CurrentUser mockUser = CurrentUser(
    photoUrl: 'fake-photo',
    email: 'some-email',
    displayName: 'some-displayName');

class AuthBlocMock extends AuthBloc {
  final AuthService service;
  final AuthState initStateToUse;
  final AuthState state;

  AuthBlocMock({@required this.service, this.initStateToUse, this.state})
      : super(service: service, initStateToUse: initStateToUse);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthInitEvent) {
      yield AuthFailedState();
    } else if (event is AuthLoginWithGoogleEvent) {
      yield AuthSuccessState(user: mockUser);
    } else if (event is AuthSuccessEvent) {
      yield AuthSuccessState(user: mockUser);
    } else if (event is AuthFailedEvent) {
      yield AuthFailedState();
    }
  }
}

void main() {
  AuthServiceMock authServiceMock;
  DataBloc dataBloc;
  AuthBlocMock authBloc;
  ApiService apiService;
  MockClient mockClient;
  setUp(() {
    // Data & Api Service
    LocalStorageServiceMock localStorageServiceMock = LocalStorageServiceMock();
    when(localStorageServiceMock.getApiKey())
        .thenAnswer((_) => Future.value('fake_key'));
    when(localStorageServiceMock.getCountryFlag())
        .thenAnswer((_) => Future.value('fake_country_flag'));
    mockClient = MockClient((request) async {
      return Response(json.encode(exampleJsonResponse), 200);
    });
    apiService = ApiService(mockClient, localStorageServiceMock);
    dataBloc = DataBloc(service: apiService);

    // Auth & AuthBloc
    authServiceMock = AuthServiceMock();
    when(authServiceMock.signInWithGoogle())
        .thenAnswer((_) => Future.value(mockUser));
    authBloc = AuthBlocMock(service: authServiceMock, state: AuthFailedState());
  });

  tearDown(() {
    authBloc?.close();
    dataBloc?.close();
  });

  group('Actions', () {
    testWidgets('AuthLoginButton', (WidgetTester tester) async {
      AuthBloc authBloc = AuthBloc(service: authServiceMock);
      await tester.pumpWidget(
        MaterialApp(
            home: BlocProvider(
          create: (context) => authBloc,
          child: BlocProvider(
            create: (context) => dataBloc,
            child: AuthLoginButton(),
          ),
        )),
      );

      // Auth Logout Button
      Finder authLoginButton = find.byType(AuthLoginButton);
      expect(authLoginButton, findsOneWidget);
      await tester.tap(authLoginButton);
      expectLater(
        authBloc,
        emitsInOrder([
          AuthInitState(),
          AuthErrorState(),
        ]),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('AuthLogoutButton', (WidgetTester tester) async {
      AuthBloc authBloc = AuthBloc(service: authServiceMock);
      await tester.pumpWidget(
        MaterialApp(
            home: BlocProvider(
          create: (context) => authBloc,
          child: BlocProvider(
            create: (context) => dataBloc,
            child: AuthLogoutButton(),
          ),
        )),
      );

      // Auth Logout Button
      Finder authLogoutButton = find.byType(AuthLogoutButton);
      expect(authLogoutButton, findsOneWidget);
      await tester.tap(authLogoutButton);
      expectLater(
        authBloc,
        emitsInOrder([
          AuthInitState(),
          AuthFailedState(),
        ]),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('SettingsScreen', (WidgetTester tester) async {
      LocalStorageServiceMock localStorageServiceMock =
          LocalStorageServiceMock();
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

    testWidgets('NewsDetails', (WidgetTester tester) async {
      LocalStorageServiceMock localStorageServiceMock =
          LocalStorageServiceMock();
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
            child: NewsDetails(url: "fake.com", source: "source.com"),
          ),
        ),
      );
      // Auth Logout Button
      Finder screen = find.byType(NewsDetails);
      expect(screen, findsOneWidget);
    });

    testWidgets('NewsLatest', (WidgetTester tester) async {
      //TODO: TEST DataLoading & DataLoaded
      LocalStorageServiceMock localStorageServiceMock =
          LocalStorageServiceMock();
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
              child: BlocProvider(
                create: (context) => dataBloc,
                child: Provider<CurrentUser>(
                    create: (_) => mockUser, child: NewsLatest()),
              )),
        ),
      );
      // Auth Logout Button
      Finder screen = find.byType(NewsLatest);
      expect(screen, findsOneWidget);
    });
  });

  group('Screen', () {
    testWidgets('HomeScreen', (WidgetTester tester) async {
      authBloc = AuthBlocMock(
          service: authServiceMock, state: AuthSuccessState(user: mockUser));
      //  authBloc.add(AuthSuccessEvent());
      await tester.pumpWidget(AppProvider(
        httpClient: Client(),
        child: MyApp(authBloc: authBloc, authService: authServiceMock),
      ));

      Finder homeScreenFinder = find.byType(HomeScreen);
      expect(homeScreenFinder, findsOneWidget);

      // Show Drawer list
      /*Finder drawerInkwellFinder = find.byKey(Key('drawerctl-inkwell-2'));
      expect(drawerInkwellFinder, findsOneWidget);
      await tester.tap(drawerInkwellFinder);*/

      Finder drawerInkwellFinder = find.byKey(Key('drawerctl-inkwell-2'));
      expect(drawerInkwellFinder, findsOneWidget);
      await tester.tap(drawerInkwellFinder);

      // Show Settings
      Finder drawerSettingsItem = find.byKey(Key('drawer-settings-item'));
      expect(drawerSettingsItem, findsOneWidget);
      await tester.tap(drawerSettingsItem);

      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('SplashScreen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
        httpClient: Client(),
        child: MyApp(),
      ));

      Finder textFinder = find.byType(SplashScreen);
      expect(textFinder, findsOneWidget);
    });

    testWidgets('AuthScreen', (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(AppProvider(
        httpClient: Client(),
        child: MyApp(
          authBloc: authBloc,
          authService: authServiceMock,
          dataBloc: dataBloc,
          apiService: apiService,
        ),
      ));

      Finder authFinder = find.byType(AuthScreen);
      expect(authFinder, findsOneWidget);
    });
  });
}
