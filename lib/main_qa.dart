import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/widgets/app_widget.dart';
import 'package:flutter_breaking_news/src/config/config.dart';

void main() {
  FlavorConfig(flavor: Flavor.QA, color: Colors.deepPurpleAccent);
  runApp(MyApp());
}
