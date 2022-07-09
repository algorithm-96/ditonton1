part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
}

class PopularMoviesEmpty extends PopularMovieState {

  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMovieState {

  @override
  List<Object> get props => [];

}

class PopularMoviesError extends PopularMovieState {

  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMovieState {
  
  final List<Movie> result;

  PopularMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}