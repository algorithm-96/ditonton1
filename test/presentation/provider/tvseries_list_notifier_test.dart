import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/list_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvNowPlaying, GetPopularTvSeries, GetTopRateTvSeries])
void main() {
  late ListTvSeriesNotifier provider;
  late MockGetTvNowPlaying mockGetTvNowPlaying;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRateTvSeries mockGetTopRateTvSeries;
  late int listener;

  setUp(() {
    mockGetTvNowPlaying = MockGetTvNowPlaying();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRateTvSeries = MockGetTopRateTvSeries();
    listener = 0;
    provider = ListTvSeriesNotifier(
        getPopularTvSeries: mockGetPopularTvSeries,
        getTopRateTvSeries: mockGetTopRateTvSeries,
        getTvNowPlaying: mockGetTvNowPlaying)
      ..addListener(() {
        listener += 1;
      });
  });

  final testTv = TvSeries(
    voteCount: 1,
    voteAverage: 5,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    popularity: 1,
    overview:
        "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio.",
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: const ['US'],
    name: 'name',
    id: 1,
    genreIds: const [1],
    firstAirDate: 'firstAirDate',
  );
  final testTvSeries = <TvSeries>[testTv];

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(provider.stateTvNowPlaying, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      provider.fetchTvNowPlaying();
      // assert
      verify(mockGetTvNowPlaying.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      provider.fetchTvNowPlaying();
      // assert
      expect(provider.stateTvNowPlaying, RequestState.Loading);
    });

    test('should change tv when data is got successfully', () async {
      // arrange
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      await provider.fetchTvNowPlaying();
      // assert
      expect(provider.stateTvNowPlaying, RequestState.Loaded);
      expect(provider.tvNowPlaying, testTvSeries);
      expect(listener, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvNowPlaying.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvNowPlaying();
      // assert
      expect(provider.stateTvNowPlaying, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listener, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRateTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.stateTopRatedTvSeries, RequestState.Loading);
    });

    test('should change tv series data when data is got successfully',
        () async {
      // arrange
      when(mockGetTopRateTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.stateTopRatedTvSeries, RequestState.Loaded);
      expect(provider.topRatedTvSeries, testTvSeries);
      expect(listener, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRateTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.stateTopRatedTvSeries, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listener, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.statePopularTvSeries, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is got successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.statePopularTvSeries, RequestState.Loaded);
      expect(provider.popularTvSeries, testTvSeries);
      expect(listener, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.statePopularTvSeries, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listener, 2);
    });
  });

  
}
