
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommend.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommend_tvseries_event.dart';
part 'recommend_tvseries_state.dart';

class RecommendTvseriesBloc
    extends Bloc<RecommendTvseriesEvent, RecommendTvseriesState> {
  final GetTvSeriesRecommend _getTvSeriesRecommend;
  RecommendTvseriesBloc(this._getTvSeriesRecommend)
      : super(RecommendTvseriesEmpty()) {
    on<RecommendTvSeriesListener>((event, emit) async {
      final id = event.id;
      emit(RecommendTvseriesLoading());
      final result = await _getTvSeriesRecommend.execute(id);
      result.fold((f) => emit(RecommendTvseriesError(f.message)), (r) => r.isNotEmpty
            ? emit(RecommendTvseriesHasData(r))
            : emit(RecommendTvseriesEmpty()),
      );
    });
  }
}
