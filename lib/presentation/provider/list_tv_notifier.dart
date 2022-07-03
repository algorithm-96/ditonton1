import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter/cupertino.dart';

class ListTvSeriesNotifier extends ChangeNotifier {
  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;
  RequestState _statePopularTvSeries = RequestState.Empty;
  RequestState get statePopularTvSeries => _statePopularTvSeries;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;
  RequestState _stateTopRatedTvSeries = RequestState.Empty;
  RequestState get stateTopRatedTvSeries => _stateTopRatedTvSeries;

  var _tvNowPlaying = <TvSeries>[];
  List<TvSeries> get tvNowPlaying => _tvNowPlaying;
  RequestState _stateTvNowPlaying = RequestState.Empty;
  RequestState get stateTvNowPlaying => _stateTvNowPlaying;

  String _message = '';
  String get message => _message;

  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRateTvSeries getTopRateTvSeries;
  final GetTvNowPlaying getTvNowPlaying;

  ListTvSeriesNotifier(
      {required this.getPopularTvSeries,
      required this.getTopRateTvSeries,
      required this.getTvNowPlaying});

  Future<void> fetchPopularTvSeries() async {
    _statePopularTvSeries = RequestState.Loading;
    notifyListeners();
    final result = await getPopularTvSeries.execute();
    result.fold((f) {
      _statePopularTvSeries = RequestState.Error;
      _message = f.message;
      notifyListeners();
    }, (r) {
      _statePopularTvSeries = RequestState.Loaded;
      _popularTvSeries = r;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvSeries() async {
    _stateTopRatedTvSeries = RequestState.Loading;
    notifyListeners();
    final result = await getTopRateTvSeries.execute();
    result.fold((f) {
      _stateTopRatedTvSeries = RequestState.Error;
      _message = f.message;
      notifyListeners();
    }, (r) {
      _stateTopRatedTvSeries = RequestState.Loaded;
      _topRatedTvSeries = r;
      notifyListeners();
    });
  }
  Future<void> fetchTvNowPlaying() async {
    _stateTvNowPlaying= RequestState.Loading;
    notifyListeners();
    final result = await getTvNowPlaying.execute();
    result.fold((f) {
      _stateTvNowPlaying = RequestState.Error;
      _message = f.message;
      notifyListeners();
    }, (r) {
      _stateTvNowPlaying = RequestState.Loaded;
      _tvNowPlaying = r;
      notifyListeners();
    });
  }

}
