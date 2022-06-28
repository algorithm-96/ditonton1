import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable{
  bool adult;
  String backdropPath;
  List<dynamic> episodeRunTime;
  List<Genre> genres;
  String homepage;
  int id;
  String name;
  int numberOfEpisodes;
  int numberOfSeasons;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  String status;
  String type;
  double voteAverage;
  int voteCount;

  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    episodeRunTime,
    genres,
    homepage,
    id,
    name,
    numberOfEpisodes,
    numberOfSeasons,
    originalName,
    overview,
    popularity,
    posterPath,
    status,
    type,
    voteAverage,
    voteCount,
  ];
}