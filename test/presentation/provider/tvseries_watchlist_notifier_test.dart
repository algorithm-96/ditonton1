import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watch_list_tv_series.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

import 'tvseries_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvNotifier watchlistTvNotifier;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listener;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    listener = 0;
    watchlistTvNotifier =
        WatchlistTvNotifier(getWatchlistTvSeries: mockGetWatchlistTvSeries)
          ..addListener(() {
            listener += 1;
          });

      });


    test('should change tv series data when data is got successfully',
        () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      // act
      await watchlistTvNotifier.fetchWatchlistTv();
      // assert
      expect(watchlistTvNotifier.watchlistState, RequestState.Loaded);
      expect(watchlistTvNotifier.watchlistTv, [testWatchlistTv]);
      expect(listener, 2);
    });

        test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Cannot get data")));
      // act
      await watchlistTvNotifier.fetchWatchlistTv();
      // assert
      expect(watchlistTvNotifier.watchlistState, RequestState.Error);
      expect(watchlistTvNotifier.message, "Cannot get data");
      expect(listener, 2);
    });

}
