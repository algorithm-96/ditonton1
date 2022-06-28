import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TvNowPlayingNotifier extends ChangeNotifier {
  final GetTvNowPlaying getTvNowPlaying;
  TvNowPlayingNotifier(this.getTvNowPlaying);
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<TvSeries> _tvNowPlaying = [];
  List<TvSeries> get tvNowPlaying => _tvNowPlaying;
  String _message = '';
  String get message => _message;
  
  Future<void> fetchingPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();
    final result = await getTvNowPlaying.execute();

    result.fold((f) {
      _message = f.message;
      _state = RequestState.Error;
      notifyListeners();
    }, ((r) {
      _tvNowPlaying = r;
      _state = RequestState.Loaded;
      notifyListeners();
    }));
  }
}
