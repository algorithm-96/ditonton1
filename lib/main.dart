import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/tv_series_page/popular_tv_series.dart';
import 'package:core/presentation/pages/tv_series_page/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series_page/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_series_page/tv_series_page.dart';
import 'package:core/utils/ssl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Ssl.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
            create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider<PopularMovieBloc>(
            create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider<TopRatedMovieBloc>(
            create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider<DetailMovieBloc>(
            create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider<RecommendMovieBloc>(
            create: (_) => di.locator<RecommendMovieBloc>()),
        BlocProvider<MovieSearchBloc>(
            create: (_) => di.locator<MovieSearchBloc>()),
        BlocProvider<WatchlistMovieBloc>(
            create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider<TvSeriesNowPlayingBloc>(
            create: (_) => di.locator<TvSeriesNowPlayingBloc>()),
        BlocProvider<TvSeriesDetailBloc>(
            create: (_) => di.locator<TvSeriesDetailBloc>()),
        BlocProvider<TopRateTvSeriesBloc>(
            create: (_) => di.locator<TopRateTvSeriesBloc>()),
        BlocProvider<PopularTvseriesBloc>(
            create: (_) => di.locator<PopularTvseriesBloc>()),
        BlocProvider<RecommendTvseriesBloc>(
            create: (_) => di.locator<RecommendTvseriesBloc>()),
        BlocProvider<TvSeriesSearchBloc>(
            create: (_) => di.locator<TvSeriesSearchBloc>()),
        BlocProvider<WatchlistTvSeriesBloc>(
            create: (_) => di.locator<WatchlistTvSeriesBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());

            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());

            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());

            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());

            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());

            case PopularTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());

            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(id: id),
                  settings: settings);

            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());

            case SearchPageTv.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchPageTv());

            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());

            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
