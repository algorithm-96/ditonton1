import 'package:dartz/dartz.dart';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepo mockTvRepo;

  setUp(() {
    mockTvRepo = MockTvSeriesRepo();
    usecase = GetPopularTvSeries(mockTvRepo);
  });

    final testTv = <TvSeries>[];

  test('should get list of Popular Tv Series from the repository', () async {
    // arrange
    when(mockTvRepo.getPopularTvSeries())
        .thenAnswer((_) async => Right(testTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTv));
  });
}