
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailBloc(this._getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<TvSeriesDetailListener>((event, emit) async {
      final id = event.id;

      emit(TvSeriesDetailLoading());

      final result = await _getTvSeriesDetail.execute(id);

      result.fold((f) => emit(TvSeriesDetailError(f.message)),
          (r) => emit(TvSeriesDetailHasData(r)));
    });
  }
}
