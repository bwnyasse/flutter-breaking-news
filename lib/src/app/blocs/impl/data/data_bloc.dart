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

import 'package:bloc/bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:meta/meta.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ApiService service;
  final DataState initStateToUse;

  DataBloc({
    @required this.service,
    this.initStateToUse,
  });

  @override
  DataState get initialState =>
      initStateToUse == null ? DataEmpty() : initStateToUse;

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();

    if (event is FetchEvent) {
      yield* _mapFetchEventToState(event);
    }
  }

  ///
  /// On FetchEvent
  ///
  Stream<DataState> _mapFetchEventToState(FetchEvent event) async* {
    final categoryLowerCase = event.category.toLowerCase();
    switch (categoryLowerCase) {
      case 'all':
        yield await _fetchData();
        break;
      case 'business':
        yield await _fetchData(category: 'business');
        break;
      case 'entertainment':
        yield await _fetchData(category: 'entertainment');
        break;
      case 'health':
        yield await _fetchData(category: 'health');
        break;
      case 'science':
        yield await _fetchData(category: 'science');
        break;
      case 'sport':
        yield await _fetchData(category: 'sport');
        break;
      case 'technology':
        yield await _fetchData(category: 'technology');
        break;
      default:
        yield DataError(message:'Unknown category');
    }
  }

  ///
  /// Method use to fetch Data from service api
  ///
  Future<DataState> _fetchData({final category}) async {
    final errorMsg = category == null
        ? 'Failed to fetch data ! Check you api key'
        : 'Failed to fetch data for category $category ! Check you api key';
    final data = category == null
        ? await service.loadTopHeadlinesNews()
        : await service.loadTopHeadlinesNews('$category');
    if (data.error == null) {
      return DataLoaded(data);
    } else {
      return DataError(message:'$errorMsg');
    }
  }
}
