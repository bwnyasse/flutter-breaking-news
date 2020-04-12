import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceException implements Exception {
  final error;
  final message;

  AuthServiceException(this.message, this.error);
}

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  FirebaseAuth get firebaseAuth => _firebaseAuth;
  GoogleSignIn get googleSignIn => _googleSignIn;
  
  ///
  /// User wants to sign in with Google Credentials
  ///
  Future<CurrentUser> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn();

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return await user();
    } catch (error) {
      throw AuthServiceException('signInWithGoogle error', error);
    }
  }

  ///
  /// User wants to sign out
  ///
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    /*return await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);*/
  }

  ///
  /// Check is the current user is signed in
  ///
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  ///
  /// Retrieve the signed in User
  ///
  Future<CurrentUser> user() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    return CurrentUser(
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl?.replaceAll("s96-c", "s300-c"),
    );
  }
}
