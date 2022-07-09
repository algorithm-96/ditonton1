part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {

}

class WatchlistMovieListener extends WatchlistMovieEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistMovieStatus extends WatchlistMovieEvent {
  final int id;

  FetchWatchlistMovieStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class SaveMovieToWatchlist extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  SaveMovieToWatchlist(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class DeleteMovieFromWatchlist extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  DeleteMovieFromWatchlist(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}
