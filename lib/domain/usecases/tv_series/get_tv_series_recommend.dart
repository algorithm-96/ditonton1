import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';

class GetTvSeriesRecommend {
  final TvSeriesRepo repository;

  GetTvSeriesRecommend(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(id) {
    return repository.getTvSeriesRecommend(id);
  }
}
