import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTvNowPlaying usecase;
  late MockTvSeriesRepo mockTvRepo;

  setUp(() {
    mockTvRepo = MockTvSeriesRepo();
    usecase = GetTvNowPlaying(mockTvRepo);
  });

    final testTv = <TvSeries>[];

  test('should get tv now playing from the repository', () async {
    // arrange
    when(mockTvRepo.getTvNowPlaying())
        .thenAnswer((_) async => Right(testTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTv));
  });
}