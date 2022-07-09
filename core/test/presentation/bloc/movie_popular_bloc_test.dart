import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('the PopularMoviesEmpty initial state should be empty ', () {
    expect(popularMoviesBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should  PopularMovieLoading state emit and then PopularMovieHasData state when data is success fetching data',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularMoviesListener()),
    expect: () => <PopularMovieState>[
      PopularMoviesLoading(),
      PopularMoviesHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockGetPopularMovies.execute()),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should PopularMoviesLoading state emits and then PopularMoviesError state when data is unsuccess fetched..',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularMoviesListener()),
    expect: () => <PopularMovieState>[
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) => PopularMoviesLoading(),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should PopularMoviesLoading state emits and then PopularMoviesEmpty state when data is empty..',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularMoviesListener()),
    expect: () => <PopularMovieState>[
      PopularMoviesLoading(),
      PopularMoviesEmpty(),
    ],
  );
}