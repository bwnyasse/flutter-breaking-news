import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/main_common.dart';
import 'package:flutter_breaking_news/src/config/config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.PROD,
    color: Colors.deepPurpleAccent,
  );
  mainCommon();
}
