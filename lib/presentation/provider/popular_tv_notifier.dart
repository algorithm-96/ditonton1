import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:flutter/cupertino.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvNotifier(this.getPopularTvSeries);
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<TvSeries> _tvSeriesPopular = [];
  List<TvSeries> get tvSeriesPopular => _tvSeriesPopular;
  String _message = '';
  String get message => _message;
  
  Future<void> fetchingPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getPopularTvSeries.execute();

    result.fold((f) {
      _message = f.message;
      _state = RequestState.Error;
      notifyListeners();
    }, ((r) {
      _tvSeriesPopular = r;
      _state = RequestState.Loaded;
      notifyListeners();
    }));
  }
}
