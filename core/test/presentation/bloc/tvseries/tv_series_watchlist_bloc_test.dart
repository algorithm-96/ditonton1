import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  DeleteWatchlistTvSeries
])
void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockDeleteWatchlistTvSeries mockDeleteWatchlistTvSeries;
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockDeleteWatchlistTvSeries = MockDeleteWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
        mockGetWatchlistTvSeries,
        mockGetWatchListStatusTvSeries,
        mockSaveWatchlistTvSeries,
        mockDeleteWatchlistTvSeries);
  });

  test('Initial State WatchlistTvSeriesEmpty should be empty', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit WatchlistTvSeriesLoading and WatchlistTvSeriesHasData when data is success added',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTv]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) async => bloc.add(WatchlistTvSeriesListener()),
      expect: () => [
            WatchlistTvSeriesLoading(),
            WatchlistTvSeriesHasData([testWatchlistTv]),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());

        return WatchlistTvSeriesListener().props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit [WatchlistTvSeriesLoading and WatchlistTvSeriesError when data is unsuccess added',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) async => bloc.add(WatchlistTvSeriesListener()),
      expect: () => [
            WatchlistTvSeriesLoading(),
            WatchlistTvSeriesError('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());

        return WatchlistTvSeriesListener().props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      
      'Should emit WatchlistTvSeriesLoading and WatchlistTvSeriesHasData when data is success added',
      
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);

        return watchlistTvSeriesBloc;
      },
      
      act: (bloc) async =>
          bloc.add(FetchWatchlistTvStatus(testTvSeriesDetail.id)),
      
      expect: () => [WatchlistTvSeriesIsAdded(true)],
      
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));

        return FetchWatchlistTvStatus(testTvSeriesDetail.id).props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit [WatchlistTvSeriesLoading and WatchlistTvSeriesError when data is unsuccess added',
      build: () {
        when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);

        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvStatus(testTvSeriesDetail.id)),
      expect: () => [
            WatchlistTvSeriesIsAdded(false),
          ],
      verify: (bloc) {
        verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));

        return FetchWatchlistTvStatus(testTvSeriesDetail.id).props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'Should emit WatchlistTvSeriesLoading and WatchlistTvSeriesHasData when data is success added',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(SaveTvSeriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
            WatchlistTvSeriesMessage('Added to Watchlist'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));

        return SaveTvSeriesToWatchlist(testTvSeriesDetail).props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should emit WatchlistTvSeriesLoading and WatchlistTvSeriesError when data is unsuccess added',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('add data Failed')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(SaveTvSeriesToWatchlist(testTvSeriesDetail)),
      expect: () => [
            WatchlistTvSeriesError('add data Failed'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));

        return SaveTvSeriesToWatchlist(testTvSeriesDetail).props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should update watchlist status when removing movie from watchlist is success',
      build: () {
        when(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Remove Data Success'));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteTvSeriesFromWatchlist(testTvSeriesDetail)),
      expect: () => [
            WatchlistTvSeriesMessage('Remove Data Success'),
          ],
      verify: (bloc) {
        verify(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetail));

        return DeleteTvSeriesFromWatchlist(testTvSeriesDetail).props;
      });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should throw failure message status when removie movie from watchlist is failed',
      build: () {
        when(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Remove Data Failed')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(DeleteTvSeriesFromWatchlist(testTvSeriesDetail)),
      expect: () => [
            WatchlistTvSeriesError('Remove Data Failed'),
          ],
      verify: (bloc) {
        verify(mockDeleteWatchlistTvSeries.execute(testTvSeriesDetail));

        return DeleteTvSeriesFromWatchlist(testTvSeriesDetail).props;
      });
}
