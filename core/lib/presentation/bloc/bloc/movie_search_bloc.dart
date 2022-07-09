
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';


part 'movie_search_event.dart';
part 'movie_search_state.dart';

EventTransformer<T> movieDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(MovieSearchEmpty()) {
    on<MovieQueryChanged>((event, emit) async {
      
      final query = event.query;

      final result = await _searchMovies.execute(query);

        result.fold(
          (l) {
            emit(MovieSearchError(l.message));
          },
          (f) {
            emit(MovieSearchHasData(f));
          },
        );
      },
      transformer: movieDebounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}
