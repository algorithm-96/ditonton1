import 'package:core/core.dart';
import 'package:core/utils/ssl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => RecommendMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(
      () => WatchlistMovieBloc(locator(), locator(), locator(), locator()));

  locator.registerFactory(() => TvSeriesNowPlayingBloc(locator()));
  locator.registerFactory(() => TvSeriesDetailBloc(locator()));
  locator.registerFactory(() => TopRateTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvseriesBloc(locator()));
  locator.registerFactory(() => RecommendTvseriesBloc(locator()));
  locator.registerFactory(() => TvSeriesSearchBloc(locator()));
  locator.registerFactory(
      () => WatchlistTvSeriesBloc(locator(), locator(), locator(), locator()));

  // use case

  //Movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //TvSeries
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRateTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommend(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => DeleteWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvNowPlaying(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepo>(
    () => TvSeriesRepoImpl(
      remoteData: locator(),
      localData: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteData>(
      () => TvSeriesRemoteDataImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalData>(
      () => TvSeriesLocalDataImpl(databaseHelperTvSeries: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Ssl());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
