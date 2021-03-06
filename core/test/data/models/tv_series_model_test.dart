
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testTvModel = TvModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: 'originalLanguage',
    originCountry: const ['en'],
  );

  final testTv = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    originalLanguage: 'originalLanguage',
    originCountry: const ['en'],
  );

  test('should be a subclass of TvModel entity', () async {
    final result = testTvModel.toEntity();
    expect(result, testTv);
  });
}