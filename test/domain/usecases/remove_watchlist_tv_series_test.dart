import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteWatchlistTvSeries usecase;
  late MockTvSeriesRepo mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepo();
    usecase = DeleteWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvSeriesRepository.deleteWatchListTvSeries(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.deleteWatchListTvSeries(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
