
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_watch_list_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  final GetWatchListStatusTvSeries _getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final DeleteWatchlistTvSeries _deleteWatchlistTvSeries;

  WatchlistTvSeriesBloc(
      this._getWatchlistTvSeries,
      this._getWatchListStatusTvSeries,
      this._saveWatchlistTvSeries,
      this._deleteWatchlistTvSeries)
     
      : super(WatchlistTvSeriesEmpty()) {
    on<WatchlistTvSeriesListener>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await _getWatchlistTvSeries.execute();
      result.fold(
        (l) => emit(WatchlistTvSeriesError(l.message)),
        (r) => r.isNotEmpty
            ? emit(WatchlistTvSeriesHasData(r))
            : emit(WatchlistTvSeriesEmpty()),
      ); 
    });

      on<FetchWatchlistTvStatus>(((event, emit) async {
        
        final id = event.id;

        final result = await _getWatchListStatusTvSeries.execute(id);

        emit(WatchlistTvSeriesIsAdded(result));
      }));

       on<SaveTvSeriesToWatchlist>(((event, emit) async {
        final movie = event.tvseries;

        final result = await _saveWatchlistTvSeries.execute(movie);

        result.fold(
          (l) => emit(WatchlistTvSeriesError(l.message)),
          (r) => emit(
            WatchlistTvSeriesMessage(r),
          ),
        );
      }),
    );

    on<DeleteTvSeriesFromWatchlist>(((event, emit) async {
        final tvseries = event.tvseries;

        final result = await _deleteWatchlistTvSeries.execute(tvseries);

        result.fold(
          (l) => emit(WatchlistTvSeriesError(l.message)),
          (r) => emit(
            WatchlistTvSeriesMessage(r),
          ),
        );
      }),
    );
   
  }
}
