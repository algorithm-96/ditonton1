import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

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