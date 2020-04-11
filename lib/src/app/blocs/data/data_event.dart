import 'package:flutter/material.dart';

enum DataEvents {
  FetchEvent,
}

class DataEvent {}

///
/// Event to Fetch Data according to a [category]
///
class FetchEvent extends DataEvent {
  final category;

  FetchEvent({@required this.category});
}
