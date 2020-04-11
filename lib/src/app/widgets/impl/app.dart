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

  MyApp({this.initStateToUse});

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
      create: (context) => AuthBloc(
          //auth service
          service: Provider.of<AuthService>(
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
              create: (context) => DataBloc(
                service: Provider.of<ApiService>(
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
