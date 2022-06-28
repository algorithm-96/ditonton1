import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watch_list_tv_series.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <TvSeries>[];
  List<TvSeries> get watchlistTv => _watchlistTv;
  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;
  String _message = '';
  String get message => _message;
  final GetWatchlistTvSeries getWatchlistTvSeries;
  WatchlistTvNotifier({required this.getWatchlistTvSeries});

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();
    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (f) {
        _watchlistState = RequestState.Error;
        _message = f.message;
        notifyListeners();
      },
      (r) {
        _watchlistState = RequestState.Loaded;
        _watchlistTv = r;
        notifyListeners();
      },
    );
  }
}
