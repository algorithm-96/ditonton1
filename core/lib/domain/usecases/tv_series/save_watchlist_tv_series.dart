import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv_series_detail.dart';
import '../../repositories/tv_series_repository.dart';


class SaveWatchlistTvSeries {
  final TvSeriesRepo repository;
  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveWatchListTvSeries(tvSeries);
  }
}
