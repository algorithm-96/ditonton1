part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {}

class TvSeriesDetailListener extends TvSeriesDetailEvent {
  final int id;
  TvSeriesDetailListener(this.id);

   @override
  List<Object?> get props => [id];
}
