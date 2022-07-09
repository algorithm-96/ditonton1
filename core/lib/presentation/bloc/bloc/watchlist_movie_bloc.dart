
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist
      )
     
      : super(WatchlistMovieEmpty()) {
    on<WatchlistMovieListener>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchlistMovies.execute();
      result.fold(
        (l) => emit(WatchlistMovieError(l.message)),
        (r) => r.isNotEmpty
            ? emit(WatchlistMovieHasData(r))
            : emit(WatchlistMovieEmpty()),
      ); 
    });

      on<FetchWatchlistMovieStatus>(((event, emit) async {
        
        final id = event.id;

        final result = await _getWatchListStatus.execute(id);

        emit(WatchlistMovieIsAdded(result));
      }));

       on<SaveMovieToWatchlist>(((event, emit) async {
        final movie = event.movieDetail;

        final result = await _saveWatchlist.execute(movie);

        result.fold(
          (l) => emit(WatchlistMovieError(l.message)),
          (r) => emit(
            WatchlistMovieMessage(r),
          ),
        );
      }),
    );

    on<DeleteMovieFromWatchlist>(((event, emit) async {
        final movie = event.movieDetail;

        final result = await _removeWatchlist.execute(movie);

        result.fold(
          (l) => emit(WatchlistMovieError(l.message)),
          (r) => emit(
            WatchlistMovieMessage(r),
          ),
        );
      }),
    );
   
  }
}
