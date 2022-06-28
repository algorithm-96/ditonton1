import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepo {
  Future<Either<Failure, List<TvSeries>>> getTvNowPlaying();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRateTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommend(int id);
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, String>> saveWatchListTvSeries(
      TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> deleteWatchListTvSeries(
      TvSeriesDetail tvSeries);
  Future<bool> addToWatchListTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
