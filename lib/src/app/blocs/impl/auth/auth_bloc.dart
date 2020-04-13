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

import 'package:bloc/bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;
  final AuthState initStateToUse;

  AuthBloc({
    @required this.service,
    this.initStateToUse,
  });

  @override
  AuthState get initialState =>
      initStateToUse == null ? AuthInitState() : initStateToUse;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthInitEvent) {
      yield* _mapAuthInitEventToState();
    } else if (event is AuthLoginWithGoogleEvent) {
      yield* _mapAuthLoginWithGoogleEventToState();
    } else if (event is AuthSuccessEvent) {
      yield* _mapAuthSuccessEventToState();
    } else if (event is AuthFailedEvent) {
      yield* _mapAuthFailedEventToState();
    }
  }

  ///
  /// On AuthInitEvent
  ///
  Stream<AuthState> _mapAuthInitEventToState() async* {
    try {
      final isSignedIn = await service.isSignedIn();
      if (isSignedIn) {
        final currentUser = await service.user();
        yield AuthSuccessState(user: currentUser);
      } else {
        yield AuthFailedState();
      }
    } catch (_) {
      yield AuthErrorState();
    }
  }

  ///
  /// On AuthLoginWithGoogleEvent
  ///
  Stream<AuthState> _mapAuthLoginWithGoogleEventToState() async* {
    try {
      await service.signInWithGoogle();
      final isSignedIn = await service.isSignedIn();
      if (isSignedIn) {
        final currentUser = await service.user();
        yield AuthSuccessState(user: currentUser);
      } else {
        yield AuthFailedState();
      }
    } catch (_) {
      yield AuthErrorState();
    }
  }

  ///
  /// On AuthSuccessEvent
  ///
  Stream<AuthState> _mapAuthSuccessEventToState() async* {
    final currentUser = await service.user();
    yield AuthSuccessState(user: currentUser);
  }

  ///
  /// On AuthFailedEvent
  ///
  Stream<AuthState> _mapAuthFailedEventToState() async* {
    yield AuthFailedState();
    service.signOut();
  }
}
