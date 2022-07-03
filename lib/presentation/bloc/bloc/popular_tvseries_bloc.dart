import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTvseriesBloc
    extends Bloc<PopularTvseriesEvent, PopularTvseriesState> {
  final GetPopularTvSeries _getPopularTvSeries;

  PopularTvseriesBloc(this._getPopularTvSeries) : super(PopularTvSeriesEmpty()) {
    on<PopularTvseriesEvent>((event, emit) async {

       emit(PopularTvSeriesLoading());

      final result = await _getPopularTvSeries.execute();

      result.fold(
        
        (failure) => emit(PopularTvSeriesErorr(failure.message)),
        (data) => data.isNotEmpty

            ? emit(PopularTvSeriesHasData(data))
            : emit(PopularTvSeriesEmpty()),
      );
      
    });
  }
}
