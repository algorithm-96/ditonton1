import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepo mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepo();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    
    when(mockTvSeriesRepository.saveWatchListTvSeries(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act

    final result = await usecase.execute(testTvSeriesDetail);
    // assert

    verify(mockTvSeriesRepository.saveWatchListTvSeries(testTvSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}