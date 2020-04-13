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
