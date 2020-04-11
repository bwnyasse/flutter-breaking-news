import 'dart:convert';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:http/http.dart' show Client;

class ApiServiceException implements Exception {
  final message;

  ApiServiceException(this.message);
}

class ApiService {
  final Client httpClient;
  final LocalStorageService _storageService;

  ApiService(this.httpClient, this._storageService);

  ///
  /// Get Top HeadLines News
  ///
  Future<ArticlesResponse> loadTopHeadlinesNews([String type]) async {
    String apiKey = await _storageService.getApiKey();
    String country = await _storageService.getCountryFlag();

    final _newsAPIUrl =
        'https://newsapi.org/v2/top-headlines?country=${country.toLowerCase()}&apiKey=$apiKey';

    try {
      final url = type == null ? _newsAPIUrl : '$_newsAPIUrl&category=$type';
      final response = await httpClient.get(url);

      if (response.statusCode != 200) {
        throw ApiServiceException('ApiService - Request Error: ${response.statusCode}');
      }

      final data = json.decode(response.body);

      return ArticlesResponse.fromJson(data);
    } catch (error, stacktrace) {
      return ArticlesResponse.withError(
        error: error,
        stackTrace: stacktrace,
      );
    }
  }
}
