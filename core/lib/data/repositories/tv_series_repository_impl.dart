import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class TvSeriesRepoImpl implements TvSeriesRepo {
  final TvSeriesLocalData localData;
  final TvSeriesRemoteData remoteData;

  TvSeriesRepoImpl({required this.localData, required this.remoteData});

  @override
  Future<bool> addToWatchListTvSeries(int id) async {
    final result = await localData.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> deleteWatchListTvSeries(
      TvSeriesDetail tvSeries) async {
    try {
      final result = await localData
          .deleteWatchlistTvSeries(TvSeriesDataTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteData.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SslFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRateTvSeries() async {
    try {
      final result = await remoteData.getTopRateTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SslFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) async {
    try {
      final result = await remoteData.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SslFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommend(int id) async {
    try {
      final result = await remoteData.getTvSeriesRecommend(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }on TlsException {
      return Left(SslFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    final result = await localData.getWatchlistTvSeries();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> saveWatchListTvSeries(
      TvSeriesDetail tvSeries) async {
    try {
      final result = await localData
          .saveWatchlistTvSeries(TvSeriesDataTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteData.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SslFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvNowPlaying() async {
    try {
      final result = await remoteData.getTvNowPlaying();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SslFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }
}
