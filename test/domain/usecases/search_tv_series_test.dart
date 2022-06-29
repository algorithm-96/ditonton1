import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepo mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepo();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final testTvSeries = <TvSeries>[];
  final testQuery = 'Metal Family';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(testQuery))
        .thenAnswer((_) async => Right(testTvSeries));
    // act
    final result = await usecase.execute(testQuery);
    // assert
    expect(result, Right(testTvSeries));
  });
}
