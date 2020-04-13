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

import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../common.dart';



main() {
  AuthServiceMock serviceMock;
  AuthBloc authBloc;

  setUp(() {
    serviceMock = AuthServiceMock();
    authBloc = AuthBloc(service: serviceMock);
  });

  tearDown(() {
    authBloc?.close();
  });

  test('close does not emit new app state', () {
    authBloc.close();

    expectLater(
      authBloc,
      emitsInOrder([AuthInitState(), emitsDone]),
    );
  });

  group('AuthState', () {
    test('AuthInitState : initialState', () {
      expect(authBloc.initialState, AuthInitState());
    });

    group('_mapAuthInitEventToState', () {
      test('AuthSuccessState', () {
        CurrentUser expectedUser = CurrentUser(
              displayName: "bobo",
              email: "bobo@gmail.com",
              photoUrl: "photourl",
            );
        when(serviceMock.isSignedIn()).thenAnswer((_) => Future.value(true));
        when(serviceMock.user()).thenAnswer((_) => Future.value(expectedUser));
        final expectedResponse = [
          AuthInitState(),
          AuthSuccessState(user:expectedUser),
        ];

        authBloc.add(AuthInitEvent());
        expectLater
        (
          authBloc,
          emitsInOrder(expectedResponse),
        );
      });
      test('AuthFailedState', () {
        when(serviceMock.isSignedIn()).thenAnswer((_) => Future.value(false));

        final expectedResponse = [
          AuthInitState(),
          AuthFailedState(),
        ];

        authBloc.add(AuthInitEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
      });
      test('AuthErrorState', () {
        when(serviceMock.isSignedIn()).thenThrow(Error);

        final expectedResponse = [
          AuthInitState(),
          AuthErrorState(),
        ];

        authBloc.add(AuthInitEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
      });
    });

    group('_mapAuthLoginWithGoogleEventToState(', () {
      test('AuthSuccessState', () {
        CurrentUser expectedUser = CurrentUser(
              displayName: "bobo",
              email: "bobo@gmail.com",
              photoUrl: "photourl",
            );
        when(serviceMock.isSignedIn()).thenAnswer((_) => Future.value(true));
        when(serviceMock.user()).thenAnswer((_) => Future.value(expectedUser));
        final expectedResponse = [
          AuthInitState(),
          AuthSuccessState(user:expectedUser),
        ];

        authBloc.add(AuthLoginWithGoogleEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
      });
      test('AuthFailedState', () {
        when(serviceMock.isSignedIn()).thenAnswer((_) => Future.value(false));

        final expectedResponse = [
          AuthInitState(),
          AuthFailedState(),
        ];

        authBloc.add(AuthLoginWithGoogleEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
      });
      test('AuthErrorState', () {
        when(serviceMock.isSignedIn()).thenThrow(Error);

        final expectedResponse = [
          AuthInitState(),
          AuthErrorState(),
        ];

        authBloc.add(AuthLoginWithGoogleEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
      });
    });

    test('_mapAuthSuccessEventToState', () {
        CurrentUser expectedUser = CurrentUser(
              displayName: "bobo",
              email: "bobo@gmail.com",
              photoUrl: "photourl",
            );
        when(serviceMock.user()).thenAnswer((_) => Future.value(expectedUser));
        final expectedResponse = [
          AuthInitState(),
          AuthSuccessState(user:expectedUser),
        ];

        authBloc.add(AuthSuccessEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
    });

    test('_mapAuthFailedEventToState', () {

        final expectedResponse = [
          AuthInitState(),
          AuthFailedState(),
        ];

        authBloc.add(AuthFailedEvent());

        expectLater(
          authBloc,
          emitsInOrder(expectedResponse),
        );
    });

  });
}
