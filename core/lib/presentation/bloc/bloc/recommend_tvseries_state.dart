part of 'recommend_tvseries_bloc.dart';

abstract class RecommendTvseriesState extends Equatable {

}

class RecommendTvseriesEmpty extends RecommendTvseriesState {
    
  @override
  List<Object> get props => [];
}

class RecommendTvseriesLoading extends RecommendTvseriesState {

  @override
  List<Object?> get props => [];
}

class RecommendTvseriesError extends RecommendTvseriesState {
  final String message;

  RecommendTvseriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendTvseriesHasData extends RecommendTvseriesState {
  final List<TvSeries> result;

  RecommendTvseriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
