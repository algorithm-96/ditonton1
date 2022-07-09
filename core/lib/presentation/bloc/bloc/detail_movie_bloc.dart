
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()) {
    on<DetailMovieListener>((event, emit) async {

      final id = event.id;
      emit(DetailMovieLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (l) => emit(DetailMovieError(l.message)),
        (r) => emit(DetailMovieHasData(r)),
      );
    });
  }
}
