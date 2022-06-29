import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRateTvSeries usecase;
  late MockTvSeriesRepo mockTvRepo;

  setUp(() {
    mockTvRepo = MockTvSeriesRepo();
    usecase = GetTopRateTvSeries(mockTvRepo);
  });

    final testTv = <TvSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepo.getTopRateTvSeries())
        .thenAnswer((_) async => Right(testTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTv));
  });
}