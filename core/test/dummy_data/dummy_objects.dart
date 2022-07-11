
import 'package:core/core.dart';
final testMovie = Movie(
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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'backdropPath',
  episodeRunTime: const [60],
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  name: 'name',
  numberOfEpisodes: 10,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  status: 'status',
  type: 'type',
  voteAverage: 1,
  voteCount: 1, 
  adult: false,
);
const testTvDataTable = TvSeriesDataTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testTvMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};

final testWatchlistTv = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeries = TvSeries(
    backdropPath: '/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg',
    firstAirDate: '2022-03-24',
    genreIds: const [
      10759,
      10765
    ],
    id: 52814,
    name: 'Halo',
    originCountry: const [
      "US"
    ],
    originalLanguage: 'en',
    originalName: 'Halo',
    overview: 'Depicting an epic 26th-century conflict between humanity and an'
        'alien threat known as the Covenant, the series weaves deeply drawn'
        'personal stories with action, adventure and a richly imagined vision'
        'of the future',
    popularity: 6106.197,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.8,
    voteCount: 376
);

final testTvSeriesList = [testTvSeries];