import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepo repository;
  GetWatchlistTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getWatchlistTvSeries();
  }
}
