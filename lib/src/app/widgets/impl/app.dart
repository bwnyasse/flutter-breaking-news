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

//import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:provider/provider.dart';

///
/// TODO: Splash Screen
///
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}

///
/// The App Entry Point
///
class MyApp extends StatelessWidget {
  final initStateToUse;
  final AuthBloc authBloc;
  final DataBloc dataBloc;
  final AuthService authService;
  final ApiService apiService;

  MyApp({
    this.initStateToUse,
    this.authBloc,
    this.dataBloc,
    this.authService,
    this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    // Overall style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      //   Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return BlocProvider(
      create: (context) => authBloc ??
          AuthBloc(
              //auth service
              service: authService??Provider.of<AuthService>(
                context,
                listen: false,
              ),
              initStateToUse: initStateToUse)
        ..add(AuthInitEvent()),
      child: _buildMaterialApp(),
    );
  }

  Widget _buildMaterialApp() => MaterialApp(
        title: 'Breaking News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: AppTheme.textTheme,
          //platform: TargetPlatform.android,
        ),
        home: _buildContent(),
      );

  Widget _buildContent() => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthFailedState) {
            return AuthScreen();
          }

          if (state is AuthSuccessState) {
            return BlocProvider(
              create: (context) => dataBloc??DataBloc(
                service: apiService??Provider.of<ApiService>(
                  context,
                  listen: false,
                ),
              ),
              child: Provider<CurrentUser>(
                  create: (_) => state.user, child: HomeScreen()),
            );
          }
          return SplashScreen();
        },
      );
}
