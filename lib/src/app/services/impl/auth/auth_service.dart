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
