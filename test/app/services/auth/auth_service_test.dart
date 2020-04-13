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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_breaking_news/src/app/models/impl/user.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/mockito.dart';

class MockGoogleSignInWithError extends Mock implements GoogleSignIn {
  @override
  Future<GoogleSignInAccount> signIn() {
    throw ("some arbitrary error");
  }
}

class AuthServiceMock extends AuthService {
  AuthServiceMock({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  }) : super(firebaseAuth: firebaseAuth, googleSignIn: googleSignIn);

  bool didRequestLogout = false;
  @override
  Future<void> signOut() {
    super.signOut();
    didRequestLogout = true;
    return Future.value();
  }
}

main() {
  final googleSignInMock = MockGoogleSignIn();
  final firebaseAuthMock = MockFirebaseAuth();
  AuthServiceMock service;

  setUp(() {
    service = AuthServiceMock(
      firebaseAuth: firebaseAuthMock,
      googleSignIn: googleSignInMock,
    );
  });

  test('init', () {
    AuthServiceMock serviceInit = AuthServiceMock();
    expect(serviceInit.firebaseAuth, isNot(null));
    expect(serviceInit.googleSignIn, isNot(null));
  });

  group('signInWithGoogle', () {
    test('success', () async {
      CurrentUser user = await service.signInWithGoogle();
      expect(user.displayName, 'Bob');
    });
    test('error', () async {
      AuthService serviceWithError = AuthService(
        firebaseAuth: firebaseAuthMock,
        googleSignIn: MockGoogleSignInWithError(),
      );
      expect(
        () async => await serviceWithError.signInWithGoogle(),
        throwsA(predicate((e) =>
            e is AuthServiceException &&
            e.message == 'signInWithGoogle error')),
      );
    });
  });

  test('user', () async {
    await service.signInWithGoogle();
    CurrentUser user = await service.user();
    expect(user.email, null); // Not mock in the lib
    expect(user.displayName, 'Bob');
    expect(user.photoUrl, null); // Not mock in the lib
  });

  test('signOut', () async {
    await service.signInWithGoogle();
    FirebaseUser user = await firebaseAuthMock.currentUser();
    expect(user.displayName, 'Bob');
    await service.signOut();
    expect(service.didRequestLogout,true);
  });

  test('isSignedIn', () async {
    await service.signInWithGoogle();
    bool state = await service.isSignedIn();
    expect(state, true); // Not mock in the lib
  });

  tearDown(() {});
}
