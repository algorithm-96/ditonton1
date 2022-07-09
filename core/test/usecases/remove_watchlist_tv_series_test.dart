import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

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
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.deleteWatchListTvSeries(testTvSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
