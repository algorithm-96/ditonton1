import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommend.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:flutter/cupertino.dart';

class DetailTvNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommend getTvSeriesRecommend;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final DeleteWatchlistTvSeries deleteWatchlistTvSeries;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;

  DetailTvNotifier(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecommend,
      required this.saveWatchlistTvSeries,
      required this.deleteWatchlistTvSeries,
      required this.getWatchListStatusTvSeries});

  static const messageAdded = 'Added to watchlist';
  static const messageDeleted = 'Delete from watchlist';

  late TvSeriesDetail _seriesDetail;
  TvSeriesDetail get seriesDetail => _seriesDetail;
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  List<TvSeries> _tvSeriesRecommend = [];
  List<TvSeries> get tvSeriesRecommend => _tvSeriesRecommend;
  RequestState _recommendState = RequestState.Empty;
  RequestState get recommendState => _recommendState;
  bool _addedToWatchList = false;
  bool get addedToWatchlist => _addedToWatchList;
  String _message = '';
  String get messsage => _message;
  String _watchlistmessage = '';
  String get watchlistMessage => _watchlistmessage;

  Future<void> fetchDetailTvSeries(int id) async {
    _state = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommend.execute(id);
    detailResult.fold(
      (f) {
        _state = RequestState.Error;
        _message = f.message;
        notifyListeners();
      },
      (r) {
        _recommendState = RequestState.Loading;
        _seriesDetail = r;
        notifyListeners();
        recommendationResult.fold(
          (f) {
            _recommendState = RequestState.Error;
            _message = f.message;
          },
          (series) {
            _recommendState = RequestState.Loaded;
            _tvSeriesRecommend = series;
          },
        );
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> deleteWatchlistTv(TvSeriesDetail tvSeriesDetail) async {
    final result = await deleteWatchlistTvSeries.execute(tvSeriesDetail);
    await result.fold((f) async {
      _watchlistmessage = f.message;
    }, (r) async {
      _watchlistmessage = r;
    });
    await loadedWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> addWatchlistTv(TvSeriesDetail tvSeriesDetail) async {
    final result = await saveWatchlistTvSeries.execute(tvSeriesDetail);
    await result.fold((f) async {
      _watchlistmessage = f.message;
    }, (r) async {
      _watchlistmessage = r;
    });
    await loadedWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> loadedWatchlistStatus(int id) async {
    final result = await getWatchListStatusTvSeries.execute(id);
    _addedToWatchList = result;
    notifyListeners();
  }
}
