
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
