import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/providers/providers.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:http/http.dart';

void mainCommon() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AppProvider(
      httpClient: Client(),
      child: MyApp(),
    ),
  );
}