library config;

import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/utils/app_utils.dart' as app_utils;

///
/// RUNNING ENVIRONMENT
///
enum Flavor {
  DEV,
  QA, // Example Firebase App Distribution
  PROD, // Play & App Store
}

///
///
///
class FlavorValues {
  // We can add other flavor specific values, e.g database name, baseUrl
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;

  static FlavorConfig _instance;

  factory FlavorConfig({
    @required Flavor flavor,
    Color color: Colors.blue,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      app_utils.enumName(flavor.toString()),
      color,
    );
    return _instance;
  }

  FlavorConfig._internal(
    this.flavor,
    this.name,
    this.color,
  );

  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PROD;

  static bool isDevelopment() => _instance.flavor == Flavor.DEV;

  static bool isQA() => _instance.flavor == Flavor.QA;
}
