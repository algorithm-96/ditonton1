import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRateTvSeriesBloc extends Bloc<TopRateTvSeriesEvent, TopRateTvSeriesState> {
  
  final GetTopRateTvSeries _getTopRateTvSeries;
  
  TopRateTvSeriesBloc(this._getTopRateTvSeries) : super(TopRateTvSeriesEmpty()) {
    on<TopRateTvSeriesListener>((event, emit) async {
      emit(TopRateTvSeriesLoading());
      final result = await _getTopRateTvSeries.execute();
      result.fold(
        (l) => emit(TopRatedTvSeriesError(l.message)),
        (r) => r.isNotEmpty
            ? emit(TopRatedTvSeriesHasData(r))
            : emit(TopRateTvSeriesEmpty()),
      );
    });
  }
}
