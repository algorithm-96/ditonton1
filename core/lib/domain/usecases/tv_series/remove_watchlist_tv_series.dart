
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv_series_detail.dart';
import '../../repositories/tv_series_repository.dart';

class DeleteWatchlistTvSeries {
  final TvSeriesRepo repository;

  DeleteWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeriesDetail) {
    return repository.deleteWatchListTvSeries(tvSeriesDetail);
  }
}
