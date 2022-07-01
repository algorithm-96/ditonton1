import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_data_table.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class TvSeriesRepoImpl implements TvSeriesRepo {
  final TvSeriesLocalData localData;
  final TvSeriesRemoteData remoteData;

  TvSeriesRepoImpl({required this.localData, required this.remoteData});

  @override
  Future<bool> addToWatchListTvSeries(int id) async {
    // TODO: implement addToWatchListTvSeries
    final result = await localData.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> deleteWatchListTvSeries(
      TvSeriesDetail tvSeries) async {
    // TODO: implement deleteWatchListTvSeries
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
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommend(
      int id) async {
        
    try {
      final result = await remoteData.getTvSeriesRecommend(id);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    // TODO: implement getWatchlistTvSeries
    final result = await localData.getWatchlistTvSeries();
    return Right(result.map((e) => e.toEntity()).toList());
  }
  

  @override
  Future<Either<Failure, String>> saveWatchListTvSeries(
      TvSeriesDetail tvSeries) async {
    // TODO: implement saveWatchListTvSeries
    try {
      final result = await localData
          .saveWatchlistTvSeries(TvSeriesDataTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw (e);
    }

  }

    @override
    Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
      // TODO: implement searchTvSeries
       try {
      final result = await remoteData.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
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
    }
  }
}
