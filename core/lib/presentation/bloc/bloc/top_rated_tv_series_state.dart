part of 'top_rated_tv_series_bloc.dart';

abstract class TopRateTvSeriesState extends Equatable {}



class TopRateTvSeriesEmpty extends TopRateTvSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRateTvSeriesLoading extends TopRateTvSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesError extends TopRateTvSeriesState {

  final String message;
  TopRatedTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedTvSeriesHasData extends TopRateTvSeriesState {
  final List<TvSeries> result;
  TopRatedTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}