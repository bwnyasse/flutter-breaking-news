import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/providers/providers.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';

void mainCommon() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppProvider(
      dio: Dio(),
      child: MyApp(),
    ),
  );
}