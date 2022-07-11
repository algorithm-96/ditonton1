import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'tv_series_now_playing_event.dart';
part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingBloc
    extends Bloc<TvSeriesNowPlayingEvent, TvSeriesNowPlayingState> {
  final GetTvNowPlaying getTvNowPlaying;

  TvSeriesNowPlayingBloc(this.getTvNowPlaying)
      : super(TvSeriesNowPlayingEmpty()) {
    on<TvSeriesNowPlayingEvent>((event, emit) async {
      emit(TvSeriesNowPlayingLoading());

      final result = await getTvNowPlaying.execute();

      result.fold(
          (l) => emit(TvSeriesNowPlayingError(l.message)),
          (r) => r.isNotEmpty
              ? emit(TvSeriesNowPlayingHasData(r))
              : emit(TvSeriesNowPlayingEmpty()));
    });
  }
}
