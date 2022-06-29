import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/movie_model/genre_model.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepoImpl repository;
  late MockTvSeriesRemoteData mockRemoteDataSource;
  late MockTvSeriesLocalData mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteData();
    mockLocalDataSource = MockTvSeriesLocalData();
    repository = TvSeriesRepoImpl(
      remoteData: mockRemoteDataSource,
      localData: mockLocalDataSource,
    );
  });

  final testTvModel = TvModel(
      posterPath: "/y2roOFsew9nJKKVwwJCHSyzgpK9.jpg",
      popularity: 130.362,
      id: 61374,
      backdropPath: "/yOarY3Yo0NMkuTuft87M5oAZa3C.jpg",
      voteAverage: 8.5,
      overview:
      "Ken Kaneki is a bookworm college student who meets a girl names Rize at a cafe he frequents. They're the same age and have the same interests, so they quickly become close. Little does Kaneki know that Rize is a ghoul – a kind of monster that lives by hunting and devouring human flesh. When part of her special organ – \"the red child\" – is transplanted into Kaneki, he becomes a ghoul himself, trapped in a warped world where humans are not the top of the food chain.",
      originCountry: ["JP"],
      genreIds: [10759,16,18,9648],
      originalLanguage: "ja",
      voteCount: 1821,
      name: "Tokyo Ghoul",
      originalName: "東京喰種トーキョーグール",
      firstAirDate: '2018-05-02'
  );

  final testTv = TvSeries(
      posterPath: "/y2roOFsew9nJKKVwwJCHSyzgpK9.jpg",
      popularity: 130.362,
      id: 61374,
      backdropPath: "/yOarY3Yo0NMkuTuft87M5oAZa3C.jpg",
      voteAverage: 8.5,
      overview:
      "Ken Kaneki is a bookworm college student who meets a girl names Rize at a cafe he frequents. They're the same age and have the same interests, so they quickly become close. Little does Kaneki know that Rize is a ghoul – a kind of monster that lives by hunting and devouring human flesh. When part of her special organ – \"the red child\" – is transplanted into Kaneki, he becomes a ghoul himself, trapped in a warped world where humans are not the top of the food chain.",
      originCountry: ["JP"],
      genreIds: [10759,16,18,9648],
      originalLanguage: "ja",
      voteCount: 1821,
      name: "Tokyo Ghoul",
      originalName: "東京喰種トーキョーグール", 
      firstAirDate: '2018-05-02');

  final testTvModelList = <TvModel>[testTvModel];
  final testTvList = <TvSeries>[testTv];

  group('On The Air Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvNowPlaying())
              .thenAnswer((_) async => testTvModelList);
          // act
          final result = await repository.getTvNowPlaying();
          // assert
          verify(mockRemoteDataSource.getTvNowPlaying());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvNowPlaying()).thenThrow(ServerException());
          // act
          final result = await repository.getTvNowPlaying();
          // assert
          verify(mockRemoteDataSource.getTvNowPlaying());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvNowPlaying())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvNowPlaying();
          // assert
          verify(mockRemoteDataSource.getTvNowPlaying());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tv Series', () {
    test('should return movie list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenAnswer((_) async => testTvModelList);
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries()).thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tv Series', () {
    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRateTvSeries())
              .thenAnswer((_) async => testTvModelList);
          // act
          final result = await repository.getTopRateTvSeries();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRateTvSeries()).thenThrow(ServerException());
          // act
          final result = await repository.getTopRateTvSeries();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRateTvSeries())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRateTvSeries();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get Tv Detail', () {
    final testId = 1;

    final testTvResponse = TvSeriesDetailModel(
      backdropPath: 'backdropPath',
      episodeRunTime: [60],
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: 'homepage',
      id: 1,
      name: 'name',
      numberOfEpisodes: 10,
      numberOfSeasons: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'status',
      type: 'type',
      voteAverage: 1,
      voteCount: 1, 
      adult: false,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(testId))
              .thenAnswer((_) async => testTvResponse);
          // act
          final result = await repository.getTvSeriesDetail(testId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(testId));
          expect(result, equals(Right(testTvSeriesDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(testId)).thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesDetail(testId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(testId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesDetail(testId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesDetail(testId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesDetail(testId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Recommendations', () {
    final testTvList = <TvModel>[];
    final testId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommend(testId))
          .thenAnswer((_) async => testTvList);
      // act
      final result = await repository.getTvSeriesRecommend(testId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommend(testId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(testTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommend(testId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvSeriesRecommend(testId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvSeriesRecommend(testId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvSeriesRecommend(testId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvSeriesRecommend(testId);
          // assert
          verify(mockRemoteDataSource.getTvSeriesRecommend(testId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Tv Series', () {
    final testQuery = 'the boys';

    test('should return tv series list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(testQuery))
              .thenAnswer((_) async => testTvModelList);
          // act
          final result = await repository.searchTvSeries(testQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(testQuery)).thenThrow(ServerException());
          // act
          final result = await repository.searchTvSeries(testQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvSeries(testQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvSeries(testQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final testId = 1;
      when(mockLocalDataSource.getTvSeriesById(testId)).thenAnswer((_) async => null);
      // act
      final result = await repository.addToWatchListTvSeries(testId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist', () {
    test('should return list of Tv Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvDataTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}