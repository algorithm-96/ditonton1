part of 'popular_tvseries_bloc.dart';

abstract class PopularTvseriesState extends Equatable {
  const PopularTvseriesState();

  @override
  List<Object> get props => [];
}

class PopularTvSeriesLoading extends PopularTvseriesState {}

class PopularTvSeriesEmpty extends PopularTvseriesState {}

class PopularTvSeriesErorr extends PopularTvseriesState {
  final String message;

  PopularTvSeriesErorr(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvSeriesHasData extends PopularTvseriesState {
  final List<TvSeries> results;
  
  PopularTvSeriesHasData(this.results);

  @override
  List<Object> get props => [];
}
