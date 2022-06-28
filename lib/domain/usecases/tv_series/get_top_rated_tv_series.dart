import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';
import '../../../common/failure.dart';

class GetTopRateTvSeries {
  final TvSeriesRepo repository;
  GetTopRateTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRateTvSeries();
  }
}
