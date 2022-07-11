import 'package:core/presentation/bloc/bloc/popular_tvseries_bloc.dart';
import 'package:core/presentation/bloc/bloc/top_rated_tv_series_bloc.dart';
import 'package:core/presentation/bloc/bloc/tv_series_now_playing_bloc.dart';
import 'package:core/presentation/pages/tv_series_page/tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_page_helper.dart';

void main() {
  late FakeTvSeriesNowPlayingBloc fakeTvSeriesNowPlayingBloc;

  late FakePopularTvSeriesBloc fakePopularTvSeriesBloc;

  late FakeTopRateTvSeriesBloc fakeTopRateTvSeriesBloc;


  setUp(() {
    fakeTvSeriesNowPlayingBloc = FakeTvSeriesNowPlayingBloc();
    registerFallbackValue(FakeTvSeriesNowPlayingEvent());
    registerFallbackValue(FakeTvSeriesNowPlayingState());

    fakePopularTvSeriesBloc = FakePopularTvSeriesBloc();
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());

    fakeTopRateTvSeriesBloc = FakeTopRateTvSeriesBloc();
    registerFallbackValue(FakeTopRateTvSeriesEvent());
    registerFallbackValue(FakeTopRateTvSeriesState());

    TestWidgetsFlutterBinding.ensureInitialized();
  });

   tearDown(() {
   
    fakeTvSeriesNowPlayingBloc.close();
   
    fakePopularTvSeriesBloc.close();
   
    fakeTopRateTvSeriesBloc.close();
  });

Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesNowPlayingBloc>(
          create: (context) => fakeTvSeriesNowPlayingBloc,
        ),
        BlocProvider<PopularTvseriesBloc>(
          create: (context) => fakePopularTvSeriesBloc,
        ),
        BlocProvider<TopRateTvSeriesBloc>(
          create: (context) => fakeTopRateTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display circular progress indicator',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesNowPlayingBloc.state)
        .thenReturn(TvSeriesNowPlayingLoading());
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesLoading());
    when(() => fakeTopRateTvSeriesBloc.state)
        .thenReturn(TopRateTvSeriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget( TvSeriesPage()));

    expect(circularProgressIndicatorFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display listview of TvSeriesNowPlaying when HasData state is happen',
      (WidgetTester tester) async {
  
    when(() => fakeTvSeriesNowPlayingBloc.state)
        .thenReturn(TvSeriesNowPlayingHasData(testTvSeriesList));
  
    when(() => fakePopularTvSeriesBloc.state)
        .thenReturn(PopularTvSeriesHasData(testTvSeriesList));
  
    when(() => fakeTopRateTvSeriesBloc.state)
        .thenReturn(TopRatedTvSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(TvSeriesPage()));

    expect(listViewFinder, findsWidgets);
  });

}
