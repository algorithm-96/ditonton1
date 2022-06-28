import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter/cupertino.dart';

class SearchTvNotifier extends ChangeNotifier {
  final SearchTvSeries searchTv;
  SearchTvNotifier({required this.searchTv});
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<TvSeries> _searchTvResult = [];
  List<TvSeries> get searchTvResult => _searchTvResult;
  String _message = '';
  String get message => _message;

  Future<void> fetchSearchTv(String query) async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await searchTv.execute(query);
    result.fold((f) {
      _message = f.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (r) {
      _searchTvResult = r;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
