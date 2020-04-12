import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceMock extends Mock implements AuthService {}

class ApiServiceMock extends Mock implements ApiService {}

class LocalStorageServiceMock extends Mock implements LocalStorageService {}

// Example from newsapi.org
final exampleJsonResponse = {
  "status": "ok",
  "totalResults": 2,
  "articles": [
    {
      "source": {"id": null, "name": "source1.com"},
      "author": "author 1",
      "title": "Title 1",
      "description": "Description 1",
      "url": "https://url1.com",
      "urlToImage": "https://images.url1.com",
      "publishedAt": "2020-04-11T17:00:00Z",
      "content": "content 1"
    },
    {
      "source": {"id": null, "name": "source2.com"},
      "author": "author 2",
      "title": "Title 2",
      "description": "Description 2",
      "url": "https://url2.com",
      "urlToImage": "https://images.url2.com",
      "publishedAt": "2020-04-11T17:00:00Z",
      "content": "content 2"
    }
  ]
};
