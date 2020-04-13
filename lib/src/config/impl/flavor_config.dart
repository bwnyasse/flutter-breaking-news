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

library config;

import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart' as app_utils;

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

  static bool isProduction() => _instance?.flavor == Flavor.PROD;

  static bool isDevelopment() => _instance?.flavor == Flavor.DEV;

  static bool isQA() => _instance?.flavor == Flavor.QA;
}
