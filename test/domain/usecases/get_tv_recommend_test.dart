import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommend usecase;
  late MockTvSeriesRepo mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvSeriesRepo();
    usecase = GetTvSeriesRecommend(mockTvRepository);
  });

  final testId = 1;
  final testTv = <TvSeries>[];

  test('should get list of Tv Series recommendations from the repository',
          () async {
        // arrange
        when(mockTvRepository.getTvSeriesRecommend(testId))
            .thenAnswer((_) async => Right(testTv));
        // act
        final result = await usecase.execute(testId);
        // assert
        expect(result, Right(testTv));
      });
}