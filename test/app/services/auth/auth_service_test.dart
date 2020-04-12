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
