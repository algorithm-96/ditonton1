

import 'package:core/core.dart';
import 'package:core/presentation/pages/tv_series_page/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_page_helper.dart';

void main() {
   late FakeTvSeriesDetailBloc fakeTvSeriesDetailBloc;
  late FakeWatchlistTvSeriesBloc fakeWatchlistTvSeriesBloc;
  late FakeRecommendTvSeriesBloc fakeRecommendTvSeriesBloc;


   setUpAll(() {
    fakeTvSeriesDetailBloc = FakeTvSeriesDetailBloc();
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());

    fakeWatchlistTvSeriesBloc = FakeWatchlistTvSeriesBloc();
    registerFallbackValue(FakeWatchlistTvSeriesEvent());
    registerFallbackValue(FakeWatchlistTvSeriesState());

    fakeRecommendTvSeriesBloc = FakeRecommendTvSeriesBloc();
    registerFallbackValue(FakeRecommendTvSeriesEvent());
    registerFallbackValue(FakeRecommendTvSeriesState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>(
          create: (_) => fakeTvSeriesDetailBloc,
        ),
        BlocProvider<WatchlistTvSeriesBloc>(
          create: (_) => fakeWatchlistTvSeriesBloc,
        ),
        BlocProvider<RecommendTvseriesBloc>(
          create: (_) => fakeRecommendTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTvSeriesDetailBloc.close();
    fakeWatchlistTvSeriesBloc.close();
    fakeRecommendTvSeriesBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailLoading());
    
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesLoading());
    
    when(() => fakeRecommendTvSeriesBloc.state)
        .thenReturn(RecommendTvseriesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget( TvSeriesDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

testWidgets(
      'Should display add icon when Tvseries is not added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvSeriesDetailBloc.state)
        .thenReturn(TvSeriesDetailHasData(testTvSeriesDetail));
    when(() => fakeWatchlistTvSeriesBloc.state)
        .thenReturn(WatchlistTvSeriesIsAdded(false));
    when(() => fakeRecommendTvSeriesBloc.state)
        .thenReturn(RecommendTvseriesHasData(testTvSeriesList));
    final addIconFinder = find.byIcon(Icons.add);
    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: testId)));
    await tester.pump();
    expect(addIconFinder, findsOneWidget);
  });

}