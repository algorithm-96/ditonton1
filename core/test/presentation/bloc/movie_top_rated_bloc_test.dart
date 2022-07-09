

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])

void main(){

  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp((){
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('the initial state should be TopRatedMovieEmpty', (){
    expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>('should PopularMovieLoading state emits and then PopularMovieHasData state when data is success fetching data',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovieListener()),
    expect: () => [TopRatedMovieLoading(), TopRatedMovieHasData(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return topRatedMovieBloc.state.props;
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>('Should emit [Loading, Error] when TopRatedMovieListener is added',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(TopRatedMovieListener()),
    expect: () => [TopRatedMovieLoading(), TopRatedMoviesError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );


}