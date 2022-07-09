
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<NowPlayingMovieEvent>((event, emit) async {
      
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (l) => emit(NowPlayingMovieError(l.message)),
        (r) => r.isEmpty
            ? emit(NowPlayingMovieEmpty())
            : emit(NowPlayingMovieHasData(r)),
      );
    });
  }
}
