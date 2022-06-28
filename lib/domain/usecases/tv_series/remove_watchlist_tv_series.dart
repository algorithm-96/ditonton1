
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../../../common/failure.dart';

class DeleteWatchlistTvSeries {
  final TvSeriesRepo repository;

  DeleteWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeriesDetail) {
    return repository.deleteWatchListTvSeries(tvSeriesDetail);
  }
}
