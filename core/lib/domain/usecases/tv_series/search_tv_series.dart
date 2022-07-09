import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepo repository;
  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
