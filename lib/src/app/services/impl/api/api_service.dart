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
