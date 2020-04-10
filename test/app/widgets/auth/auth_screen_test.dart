import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common.dart';

class MockOnPressedFunction {
  int called = 0;

  void handler() {
    called++;
  }
}

void main() {
  AuthServiceMock serviceMock;
  AuthBloc authBloc;

  setUp(() {
    serviceMock = AuthServiceMock();
    authBloc =
        AuthBloc(service: serviceMock, initStateToUse: AuthFailedState());
  });

  tearDown(() {
    authBloc?.close();
  });

  group('Display AuthScreen', () {
    testWidgets('state: AuthFailedState', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
        create: (context) => authBloc,
        child: AuthScreen(),
      )));

      // Check AuthLoginButton is present
      Finder textFinder = find.byType(AuthLoginButton);
      expect(textFinder, findsOneWidget);

      // Check that authloginbutton can be tap  AuthInitState
      // TODO: Can be done better...
      await tester.tap(find.byType(AuthLoginButton));
    });
  });
}
