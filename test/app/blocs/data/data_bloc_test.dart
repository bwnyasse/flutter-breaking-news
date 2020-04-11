import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../common.dart';

main() {
  ApiServiceMock serviceMock;
  DataBloc dataBloc;

  setUp(() {
    serviceMock = ApiServiceMock();
    dataBloc = DataBloc(service: serviceMock);
  });

  tearDown(() {
    dataBloc?.close();
  });

  test('close does not emit new app state', () {
    dataBloc.close();

    expectLater(
      dataBloc,
      emitsInOrder([DataEmpty(), emitsDone]),
    );
  });

  group('DataError',(){
    test('in _mapFetchEventToState', () {
      when(serviceMock.loadTopHeadlinesNews()).thenThrow(Error);

      final expectedResponse = [
        DataEmpty(),
        DataLoading(),
        DataError(),
      ];

      dataBloc.add(FetchEvent(category: ''));

      expectLater(
        dataBloc,
        emitsInOrder(expectedResponse),
      );
    });
    test('in _fetchData', () {
      ArticlesResponse data = ArticlesResponse.fromJson({});
      data.error = 'something to catch error';
      when(serviceMock.loadTopHeadlinesNews(any))
          .thenAnswer((_) => Future.value(data));

      final expectedResponse = [
        DataEmpty(),
        DataLoading(),
        DataError(),
      ];

      dataBloc.add(FetchEvent(category: 'business'));

      expectLater(
        dataBloc,
        emitsInOrder(expectedResponse),
      );
    });
  });


  group('DataLoaded', () {
    [
      'all',
      'business',
      'entertainment',
      'health',
      'science',
      'sport',
      'technology',
    ].forEach((value) {
      test('$value', () {
        when(serviceMock.loadTopHeadlinesNews())
            .thenAnswer((_) => Future.value(ArticlesResponse.fromJson({})));
        when(serviceMock.loadTopHeadlinesNews(any))
            .thenAnswer((_) => Future.value(ArticlesResponse.fromJson({})));
        final expectedResponse = [
          DataEmpty(),
          DataLoading(),
          DataLoaded({}),
        ];
        dataBloc.add(FetchEvent(category: '$value'));
        expectLater(
          dataBloc,
          emitsInOrder(expectedResponse),
        );
      });
    });
  });
}
