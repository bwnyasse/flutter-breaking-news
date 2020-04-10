import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/providers/providers.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../common.dart';

void main() {
  group('Display App', () {
    testWidgets('Splash screen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
        dio: Dio(),
        child: MyApp(),
      ));

      Finder textFinder = find.byType(SplashScreen);
      expect(textFinder, findsOneWidget);
    });

    testWidgets('Auth Screen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
          dio: Dio(),
          child: BlocProvider(
            create: (context) => AuthBloc(
                service: AuthServiceMock(), ),
            child: MyApp(initStateToUse: AuthFailedState()),
          )));

      Finder textFinder = find.byType(AuthScreen);
      expect(textFinder, findsOneWidget);
    });

    testWidgets('News Screen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
          dio: Dio(),
          child: BlocProvider(
            create: (context) => AuthBloc(
                service: AuthServiceMock(), ),
            child: MyApp(initStateToUse: AuthSuccessState(user:null)),
          )));

      Finder textFinder = find.byType(NewsScreen);
      expect(textFinder, findsOneWidget);
    });

    
  });
}
