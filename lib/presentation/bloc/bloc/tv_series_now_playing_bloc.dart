import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  final GetTvNowPlaying _getTvNowPlaying;

  TvSeriesNowPlayingBloc(this._getTvNowPlaying)
      : super(TvSeriesNowPlayingEmpty()) {
    on<TvSeriesNowPlayingEvent>((event, emit) async {
      emit(TvSeriesNowPlayingLoading());

      final result = await _getTvNowPlaying.execute();

      result.fold(
          (l) => emit(TvSeriesNowPlayingError(l.message)), (r) => r.isNotEmpty ? 
          emit(TvSeriesNowPlayingHasData(r))
          : emit (TvSeriesNowPlayingEmpty())
          );
    });
  }
}
