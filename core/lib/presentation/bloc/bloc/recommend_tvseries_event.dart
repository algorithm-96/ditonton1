part of 'recommend_tvseries_bloc.dart';

abstract class RecommendTvseriesEvent extends Equatable {}

class RecommendTvSeriesListener extends RecommendTvseriesEvent {
  final int id;

  RecommendTvSeriesListener(this.id);

  @override
  List<Object> get props => [id];
}
