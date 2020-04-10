import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitState extends AuthState {}

///
/// This is the state when user is authenticated and user object is created.
///
class AuthSuccessState extends AuthState {
  final CurrentUser user;

  // user is a required parameter to create the Authenticated state
  AuthSuccessState({@required this.user});
}

///
/// state when user authentication fails
///
class AuthFailedState extends AuthState {}

///
/// state whe error occurs during the auth process
///
class AuthErrorState extends AuthState {}
