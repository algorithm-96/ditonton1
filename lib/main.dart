import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/tv_series_page/popular_tv_series.dart';
import 'package:core/presentation/pages/tv_series_page/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series_page/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_series_page/tv_series_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());

            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());

            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());

            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());

            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TopRatedTvPage());

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
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
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
