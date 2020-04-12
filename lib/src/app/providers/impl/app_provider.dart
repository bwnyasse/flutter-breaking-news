import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

///
/// My App Provider responsible to inject
/// Object as singleton
///
class AppProvider extends StatelessWidget {
  final Client httpClient;
  final Widget child;
  final AuthService authService;
  final LocalStorageService localStorageService;

  AppProvider({
    @required this.httpClient,
    this.authService,
    this.localStorageService,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => authService ?? AuthService()),
        Provider<LocalStorageService>(
            create: (_) => localStorageService ?? LocalStorageService()),
        ProxyProvider<LocalStorageService, ApiService>(
          update: (_, localStorageService, __) =>
              ApiService(httpClient, localStorageService),
        ),
      ],
      child: child,
    );
  }
}
