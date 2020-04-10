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
