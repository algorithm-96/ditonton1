import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/bloc/now_playing_movie_bloc.dart';
import 'package:core/presentation/bloc/bloc/popular_movie_bloc.dart';
import 'package:core/presentation/bloc/bloc/top_rated_movie_bloc.dart';
import 'package:core/presentation/pages/movie_page/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMovieEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMovieState {}

class FakeNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

class FakePopularMoviesEvent extends Fake implements PopularMovieEvent {}

class FakePopularMoviesState extends Fake implements PopularMovieEvent {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedMovieEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMovieState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMoviesBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMoviesBloc;
  setUp(() {
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();
    fakePopularMoviesBloc = FakePopularMoviesBloc();
    fakeTopRatedMoviesBloc = FakeTopRatedMoviesBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());

    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());

    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

   tearDown(() {
    fakeNowPlayingMoviesBloc.close();
    fakePopularMoviesBloc.close();
    fakeTopRatedMoviesBloc.close();
  });


    Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => fakePopularMoviesBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (context) => fakeTopRatedMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'page should display listview of NowPlayingMovies when HasData state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakePopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMoviesBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });
}
