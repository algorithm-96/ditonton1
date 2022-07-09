part of 'recommend_movie_bloc.dart';

abstract class RecommendMovieEvent extends Equatable {}

class RecommendMovieListener extends RecommendMovieEvent {
  final int id;

  RecommendMovieListener(this.id);

  @override
  List<Object> get props => [id];
}
