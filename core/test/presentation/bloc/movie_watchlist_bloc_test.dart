import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movie/get_watchlist_status.dart';
import 'package:core/domain/usecases/movie/remove_watchlist.dart';
import 'package:core/domain/usecases/movie/save_watchlist.dart';
import 'package:core/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies,
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  test('initial state WatchlistMovieEmpty should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });


  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should WatchlistMovieLoading state and WatchlistMovieHasData state emit when data is success fetching',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieListener()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData([testWatchlistMovie]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return WatchlistMovieListener().props;
      },
    );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should WatchlistMovieLoading state emit and then WatchlistMovieEmpty state when data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieListener()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        WatchlistMovieEmpty(),
      ],
    );

     blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should WatchlistMovieLoading state emit and then WatchlistMovieError state when data is unsuccess fetching data',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovieListener()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieLoading(),
        WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMovieLoading(),
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should be return false when the watchlist is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovieStatus(testMovieDetail.id)),
        expect: () => <WatchlistMovieState>[
              WatchlistMovieIsAdded(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return FetchWatchlistMovieStatus(testMovieDetail.id).props;
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should be return true when the watchlist is also true',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovieStatus(testMovieDetail.id)),
      expect: () => [WatchlistMovieIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        return FetchWatchlistMovieStatus(testMovieDetail.id).props;
      },
    );

     blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should update watchlist status when removing movie from watchlist is success',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieMessage('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return DeleteMovieFromWatchlist(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should throw failure message status when removie movie from watchlist is unsuccess',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                 Left(DatabaseFailure('add data Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(DeleteMovieFromWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieError('add data Failed'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return DeleteMovieFromWatchlist(testMovieDetail).props;
      },
    );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should update watchlist status when added movie to watchlist is success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(SaveMovieToWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieMessage('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return SaveMovieToWatchlist(testMovieDetail).props;
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should throw failure message status when added movie to watchlist is unsuccess',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                 Left(DatabaseFailure('Remove Data Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(SaveMovieToWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieError('Remove Data Failed'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return SaveMovieToWatchlist(testMovieDetail).props;
      },
    );

    
  

}
