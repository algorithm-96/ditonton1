import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

import '../../../common/failure.dart';
import '../../repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepo repository;
  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}