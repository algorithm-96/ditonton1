import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvSeries usecase;
  late MockTvSeriesRepo mockTvRepo;

  setUp(() {
    mockTvRepo = MockTvSeriesRepo();
    usecase = GetWatchListStatusTvSeries(mockTvRepo);
  });


  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepo.addToWatchListTvSeries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}