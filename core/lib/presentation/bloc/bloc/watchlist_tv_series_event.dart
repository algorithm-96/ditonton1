part of 'watchlist_tv_series_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {

}
class WatchlistTvSeriesListener extends WatchlistTvSeriesEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistTvStatus extends WatchlistTvSeriesEvent {
  final int id;

  FetchWatchlistTvStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class SaveTvSeriesToWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvseries;

  SaveTvSeriesToWatchlist(this.tvseries);

  @override
  List<Object?> get props => [tvseries];
}

class DeleteTvSeriesFromWatchlist extends WatchlistTvSeriesEvent {
  final TvSeriesDetail tvseries;

  DeleteTvSeriesFromWatchlist(this.tvseries);
  
  @override
  List<Object?> get props => [tvseries];
}