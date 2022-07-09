
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'recommend_movie_event.dart';
part 'recommend_movie_state.dart';

class RecommendMovieBloc
    extends Bloc<RecommendMovieEvent, RecommendMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendMovieBloc(this._getMovieRecommendations)
      : super(RecommendMovieEmpty()) {
    on<RecommendMovieListener>((event, emit) async {
      final id = event.id;

      emit(RecommendMovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold((l) => emit(RecommendMovieError(l.message)), (r) => r.isNotEmpty 
      ? emit(RecommendMovieHasData(r)) :
      emit(RecommendMovieEmpty())
      );
    });
  }
}
