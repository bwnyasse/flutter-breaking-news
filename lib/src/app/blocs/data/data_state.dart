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
