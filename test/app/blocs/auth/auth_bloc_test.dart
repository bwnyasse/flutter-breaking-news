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
