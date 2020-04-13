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
