import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movie/search_movies.dart';
import 'package:core/presentation/bloc/bloc/movie_search_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_bloc_test.mocks.dart';
@GenerateMocks([SearchMovies])
void main() {
  
   late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(mockSearchMovies);
  });

  test('initial state MovieSearchBloc should be empty', () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });


   final testMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final testMovieList = <Movie>[testMovieModel];
  const testQuery = 'spiderman';

   blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      MovieSearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const MovieSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
    },
  );

  
}