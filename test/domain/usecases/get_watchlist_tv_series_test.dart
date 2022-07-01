import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watch_list_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepo mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvSeriesRepo();
    usecase = GetWatchlistTvSeries(mockTvRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}