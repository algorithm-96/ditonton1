import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_model/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteData {
  Future<List<TvModel>> getPopularTvSeries();
  Future<List<TvModel>> getTopRateTvSeries();
  Future<List<TvModel>> getTvNowPlaying();
  Future<List<TvModel>> getTvSeriesRecommend(int id);
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id);
  Future<List<TvModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataImpl implements TvSeriesRemoteData {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';
  final http.Client client;

  TvSeriesRemoteDataImpl({required this.client});

  @override
  Future<List<TvModel>> getPopularTvSeries() async {
    // TODO: implement getPopularTvSeries

    
    final responseTvSeries =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (responseTvSeries.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(responseTvSeries.body))
          .result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRateTvSeries() async {
    // TODO: implement getTopRateTvSeries


    final responseTvSeries =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (responseTvSeries.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(responseTvSeries.body))
          .result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    // TODO: implement getTvSeriesDetail


    final responseTvSeries =
        await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (responseTvSeries.statusCode == 200) {
      return TvSeriesDetailModel.fromJson(jsonDecode(responseTvSeries.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvSeries(String query) async {
    // TODO: implement searchTvSeries

    final responseTvSeries = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (responseTvSeries.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(responseTvSeries.body))
          .result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvSeriesRecommend(int id) async {


    final responseTvSeries = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (responseTvSeries.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(responseTvSeries.body))
          .result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvNowPlaying() async {
    // TODO: implement getTvNowPlaying
    final responseTvSeries =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (responseTvSeries.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(responseTvSeries.body))
          .result;
    } else {
      throw ServerException();
    }
  }
}