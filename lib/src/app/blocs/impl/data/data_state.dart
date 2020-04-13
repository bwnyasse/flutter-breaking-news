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

class DataState extends Equatable {
  @override
  List<Object> get props => [];
}

///
/// Data Empty State
///
/// The initial state of the application without data from rest api
///
class DataEmpty extends DataState {}

///
/// Data Error State
///
/// Error occurs while loading data from rest api with an error [message].
///
class DataError extends DataState {
  final message;

  DataError({this.message});
}

///
/// Data Loading State
///
/// Data are loading ...
///
class DataLoading extends DataState {}

///
/// Data Loading State
///
/// App is loaded with [data]
///
class DataLoaded extends DataState {
  final data;

  DataLoaded(this.data);
}
