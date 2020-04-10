import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:provider/provider.dart';

///
/// My App Provider responsible to inject
/// Object as singleton
///
class AppProvider extends StatelessWidget {
  final Dio dio;
  final Widget child;

  AppProvider({
    @required this.dio,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: child,
    );
  }
}
