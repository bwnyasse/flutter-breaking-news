import 'package:flutter_breaking_news/src/app/providers/providers.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  group('Display App', () {
    testWidgets('Splash screen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
        httpClient: Client(),
        child: MyApp(),
      ));

      Finder textFinder = find.byType(SplashScreen);
      expect(textFinder, findsOneWidget);
    });

   /* testWidgets('Auth Screen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
          dio: Dio(),
          child: BlocProvider(
            create: (context) => AuthBloc(
                service: AuthServiceMock(), ),
            child: MyApp(initStateToUse: AuthFailedState()),
          )));

      Finder textFinder = find.byType(AuthScreen);
      expect(textFinder, findsOneWidget);
    });*/

   /* testWidgets('Home Screen ', (WidgetTester tester) async {
      await tester.pumpWidget(AppProvider(
          dio: Dio(),
          child: BlocProvider(
            create: (context) => AuthBloc(
                service: AuthServiceMock(), ),
            child: MyApp(initStateToUse: AuthSuccessState(user:null)),
          )));

      Finder textFinder = find.byType(HomeScreen);
      expect(textFinder, findsOneWidget);
    });*/

    
  });
}
