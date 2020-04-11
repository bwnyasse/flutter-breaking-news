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
