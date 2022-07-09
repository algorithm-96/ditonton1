part of 'recommend_movie_bloc.dart';

abstract class RecommendMovieState extends Equatable {}

class RecommendMovieEmpty extends RecommendMovieState {

  @override
  List<Object?> get props => [];
}

class RecommendMovieLoading extends RecommendMovieState {

  @override
  List<Object?> get props => [];
}

class RecommendMovieError extends RecommendMovieState {

  final String message;
  RecommendMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendMovieHasData extends RecommendMovieState {
  
  final List<Movie> result;

  RecommendMovieHasData(this.result);
  @override
  List<Object?> get props => [result];
}
