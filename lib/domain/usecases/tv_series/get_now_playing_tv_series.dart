import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

import '../../../common/failure.dart';
import '../../entities/tv_series.dart';

class GetTvNowPlaying {
  final TvSeriesRepo repository;

  GetTvNowPlaying(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvNowPlaying();
  }
}