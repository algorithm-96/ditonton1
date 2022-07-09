
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies)
   : super(PopularMoviesEmpty()) {
    on<PopularMoviesListener>((event, emit) async {
      
      emit(PopularMoviesLoading());
      final result = await getPopularMovies.execute();

      result.fold(
        (l) => emit(PopularMoviesError(l.message)),
        (r) => r.isEmpty
            ? emit(PopularMoviesEmpty())
            : emit(PopularMoviesHasData(r)),
      );
    });
  }
}
