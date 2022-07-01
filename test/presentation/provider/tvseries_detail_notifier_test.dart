import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommend.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/detail_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommend,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  DeleteWatchlistTvSeries,
])
void main() {
  late DetailTvNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommend mockGetTvSeriesRecommend;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockDeleteWatchlistTvSeries mockDeleteWatchlistTvSeries;
  late int listener;

  setUp(() {
    listener = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommend = MockGetTvSeriesRecommend();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockDeleteWatchlistTvSeries = MockDeleteWatchlistTvSeries();
    provider = DetailTvNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommend: mockGetTvSeriesRecommend,
        saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
        deleteWatchlistTvSeries: mockDeleteWatchlistTvSeries,
        getWatchListStatusTvSeries: mockGetWatchListStatusTvSeries)
      ..addListener(() {
        listener += 1;
      });
  });

  const testId = 1;
  
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

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(testId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommend.execute(testId))
        .thenAnswer((_) async => Right(testTvSeries));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchDetailTvSeries(testId);
      // assert

      verify(mockGetTvSeriesDetail.execute(testId));
      verify(mockGetTvSeriesRecommend.execute(testId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();

      // act
      provider.fetchDetailTvSeries(testId);

      // assert
      expect(provider.state, RequestState.Loading);
      expect(listener, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTvSeries(testId);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.seriesDetail, testTvSeriesDetail);
      expect(listener, 3);
    });

    test('should change recommendation tv series when data is got successfully',
        () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchDetailTvSeries(testId);

      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeriesRecommend, testTvSeries);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchDetailTvSeries(testId);
      // assert
      verify(mockGetTvSeriesRecommend.execute(testId));
      expect(provider.tvSeriesRecommend, testTvSeries);
    });

    test('should update recommendation state when data is got successfully',
        () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchDetailTvSeries(testId);

      // assert
      expect(provider.recommendState, RequestState.Loaded);
      expect(provider.tvSeriesRecommend, testTvSeries);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommend.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      // act
      await provider.fetchDetailTvSeries(testId);

      // assert
      expect(provider.recommendState, RequestState.Error);
      expect(provider.messsage, 'Failed');
    });
  });

  group('Watchlist Tv Series', () {
    test('should get the watchlist status Tv Series', () async {
      // arrange
      when(mockGetWatchListStatusTvSeries.execute(1))
          .thenAnswer((_) async => true);

      // act
      await provider.loadedWatchlistStatus(1);

      // assert
      expect(provider.addedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvSeriesDetail);
      // assert
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      // act
      await provider.deleteWatchlistTv(testTvSeriesDetail);

      // assert
      verify(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvSeriesDetail);
      // assert
      verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
      expect(provider.addedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listener, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTv(testTvSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listener, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommend.execute(testId))
          .thenAnswer((_) async => Right(testTvSeries));
      // act
      await provider.fetchDetailTvSeries(testId);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.messsage, 'Server Failure');
      expect(listener, 2);
    });
  });
}
