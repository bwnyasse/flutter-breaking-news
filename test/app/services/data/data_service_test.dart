import 'dart:convert';

import 'package:flutter_breaking_news/src/app/models/impl/news.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

import '../../common.dart';

main() {
  group('loadTopHeadlinesNews', () {
    test('status == 200', () async {
      // Mock for local storage service
      LocalStorageServiceMock localStorageServiceMock =
          LocalStorageServiceMock();
      when(localStorageServiceMock.getApiKey())
          .thenAnswer((_) => Future.value('fake_key'));
      when(localStorageServiceMock.getCountryFlag())
          .thenAnswer((_) => Future.value('fake_country_flag'));

      // Mock for httpclient
      final mockClient = MockClient((request) async {
        return Response(json.encode(exampleJsonResponse), 200);
      });
      final apiService = ApiService(mockClient, localStorageServiceMock);
      final expectedResponse = ArticlesResponse.fromJson(exampleJsonResponse);
      final actualResponse = await apiService.loadTopHeadlinesNews();
      expect(actualResponse, equals(expectedResponse));
    });

    test('status != 200', () async {
      // Mock for local storage service
      LocalStorageServiceMock localStorageServiceMock =
          LocalStorageServiceMock();
      when(localStorageServiceMock.getApiKey())
          .thenAnswer((_) => Future.value('fake_key'));
      when(localStorageServiceMock.getCountryFlag())
          .thenAnswer((_) => Future.value('fake_country_flag'));

      // Mock for httpclient
      final mockClient = MockClient((request) async {
        return Response(json.encode(exampleJsonResponse), 500);
      });
      final apiService = ApiService(mockClient, localStorageServiceMock);
      ArticlesResponse response = await apiService.loadTopHeadlinesNews('business');
      expect(response.error.runtimeType,equals(ApiServiceException));
      expect(response.error.message ,equals('ApiService - Request Error: 500'));
    });
  });
}
