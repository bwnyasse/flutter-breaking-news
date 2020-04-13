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

import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:mockito/mockito.dart';

// Example from newsapi.org
final mockJsonResponse = {
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

LocalStorageData mockLocalStorageData = LocalStorageData(
  countryFlag: 'ar',
  apiKey: 'some-api-key',
);

Map<String, dynamic> mockCountriesAsJson() => <String, dynamic>{
      "countries": [
        {"name": "Argentine", "flag": "ar"},
      ]
    };

CurrentUser mockUser = CurrentUser(
    photoUrl: 'fake-photo',
    email: 'some-email',
    displayName: 'some-displayName');

class AuthServiceMock extends Mock implements AuthService {}

class ApiServiceMock extends Mock implements ApiService {}

class LocalStorageServiceMock extends Mock implements LocalStorageService {}

class AuthBlocMock extends AuthBloc {
  final AuthService service;
  final AuthState initStateToUse;
  final AuthState state;

  AuthBlocMock({@required this.service, this.initStateToUse, this.state})
      : super(service: service, initStateToUse: initStateToUse);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthInitEvent) {
      yield AuthFailedState();
    } else if (event is AuthLoginWithGoogleEvent) {
      yield AuthSuccessState(user: mockUser);
    } else if (event is AuthSuccessEvent) {
      yield AuthSuccessState(user: mockUser);
    } else if (event is AuthFailedEvent) {
      yield AuthFailedState();
    }
  }
}


