import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/bloc/detail_movie_bloc.dart';
import 'package:core/presentation/bloc/bloc/recommend_movie_bloc.dart';
import 'package:core/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:core/presentation/pages/movie_page/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<
      DetailMovieEvent, DetailMovieState> implements DetailMovieBloc{}

class FakeDetailMovieEvent extends Fake implements DetailMovieEvent{}

class FakeDetailMovieState extends Fake implements DetailMovieState{}

class MockWatchlistMoviesBloc extends MockBloc<
      WatchlistMovieEvent, WatchlistMovieState> implements WatchlistMovieBloc{}

class FakeWatchlistMoviesEvent extends Fake implements WatchlistMovieEvent{}

class FakeWatchlistMovieState extends Fake implements WatchlistMovieState{}

class MockRecommendMoviesBloc extends MockBloc<
      RecommendMovieEvent, RecommendMovieState> implements RecommendMovieBloc{}

class FakeRecommendMoviesEvent extends Fake implements RecommendMovieEvent{}

class FakeRecommendMoviesState extends Fake implements RecommendMovieState{}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;
  late MockRecommendMoviesBloc mockMovieRecommendationBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    mockMovieRecommendationBloc = MockRecommendMoviesBloc();
  });
  setUpAll(() {
    registerFallbackValue(FakeDetailMovieState());
   
    registerFallbackValue(FakeDetailMovieEvent());

    registerFallbackValue(FakeWatchlistMoviesEvent());
   
    registerFallbackValue(FakeWatchlistMovieState());

    registerFallbackValue(FakeRecommendMoviesEvent());
   
    registerFallbackValue(FakeRecommendMoviesState());
  });
  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(create: (_) => mockMovieDetailBloc),
        BlocProvider<WatchlistMovieBloc>(create: (_) => mockWatchlistMoviesBloc),
        BlocProvider<RecommendMovieBloc>(create: (_) => mockMovieRecommendationBloc),
      ],
      child: MaterialApp(
        home: body,
      ));
  }

    testWidgets(
        'Watchlist button tought to show include symbol when motion picture not included to watchlist', (WidgetTester tester) async {
   
          when(() => mockMovieDetailBloc.state).thenReturn(DetailMovieHasData(testMovieDetail));
   
          when(() => mockWatchlistMoviesBloc.state).thenReturn( WatchlistMovieIsAdded(false));
   
          when(() => mockMovieRecommendationBloc.state).thenReturn(RecommendMovieHasData(testMovieList));

          final watchlistButtonIcon = find.byIcon(Icons.add);
          await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
          expect(watchlistButtonIcon, findsOneWidget);
        });

    testWidgets(
        'Watchlist button tought to show check symbol when motion picture is included to watchlist', (WidgetTester tester) async {
              
              when(() => mockMovieDetailBloc.state).thenReturn(DetailMovieHasData(testMovieDetail));
              
              when(() => mockMovieRecommendationBloc.state).thenReturn(RecommendMovieHasData(testMovieList));
              
              when(() => mockWatchlistMoviesBloc.state).thenReturn(WatchlistMovieIsAdded(true));

          final watchlistButtonIcon = find.byIcon(Icons.check);
          await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
          expect(watchlistButtonIcon, findsOneWidget);
        });

    
}