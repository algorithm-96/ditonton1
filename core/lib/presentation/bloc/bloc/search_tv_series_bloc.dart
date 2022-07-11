
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

EventTransformer<T> tvseriesDebounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvSeriesSearchBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;
  TvSeriesSearchBloc(this.searchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<TvSeriesQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvSeriesLoading());

        final result = await searchTvSeries.execute(query);

        result.fold(
          (failure) {
            emit(SearchTvSeriesError(failure.message));
          },
          (data) {
            emit(SearchTvSeriesHasData(data));
          },
        );
      },

      transformer: tvseriesDebounce(
        const Duration(milliseconds: 500),
      
      ),
    );
  }
}
