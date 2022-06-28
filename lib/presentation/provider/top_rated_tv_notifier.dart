import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRateTvSeries getTopRateTvSeries;
  TopRatedTvNotifier({required this.getTopRateTvSeries});
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<TvSeries> _tvSeriesTopRated = [];
  List<TvSeries> get tvSeriesTopRated => _tvSeriesTopRated;
  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTopRateTvSeries.execute();

    result.fold((f) {
      _message = f.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (r) {
      _tvSeriesTopRated = r;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
