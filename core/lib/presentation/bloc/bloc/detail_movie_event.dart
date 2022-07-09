part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {}

class DetailMovieListener extends DetailMovieEvent {
  final int id;

  DetailMovieListener(this.id);

  @override
  List<Object> get props => [id];
}
