import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataImpl tvSeriesRemoteDataImpl;
  late MockHttpClient mockHttpClient;
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';
  setUp(() {
    mockHttpClient = MockHttpClient();
    tvSeriesRemoteDataImpl = TvSeriesRemoteDataImpl(client: mockHttpClient);
  });

  group('get Now Playing TV Series', () {
    final testTvSeriesPlaying = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_on_the_air.json')))
        .result;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_on_the_air.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act

      final result = await tvSeriesRemoteDataImpl.getTvNowPlaying();
      // assert

      expect(result, equals(testTvSeriesPlaying));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange

      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act

      final call = tvSeriesRemoteDataImpl.getTvNowPlaying();
      // assert

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get Popular TV', () {
    final testPopularTv = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_popular.json')))
        .result;

    test('should return list of tv shows when response is success (200)',
        () async {
      // arrange

      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_popular.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act

      final result = await tvSeriesRemoteDataImpl.getPopularTvSeries();
      // assert

      expect(result, testPopularTv);
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = tvSeriesRemoteDataImpl.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get Top Rated TVShows', () {
    final testTopRatedTv = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_top_rated.json')))
        .result;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange

      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_top_rated.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act

      final result = await tvSeriesRemoteDataImpl.getTopRateTvSeries();
      // assert
      expect(result, testTopRatedTv);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = tvSeriesRemoteDataImpl.getTopRateTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Detail', () {
    const testId = 1;
    final testDetailTv = TvSeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));
    test('should be return tv show detail when the response code 200',
        () async {
      //arrage
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$testId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_series_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      //act
      final result = await tvSeriesRemoteDataImpl.getTvSeriesDetail(testId);
      //assert
      expect(result, equals(testDetailTv));
    });

    test('should throw a ServerException when the response code is 404',
        () async {
      //arrage

      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$testId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act

      final call = tvSeriesRemoteDataImpl.getTvSeriesDetail(testId);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Show Recommendations', () {
    final testRecommendedTv = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .result;
    const testId = 2;
    test(
        'should be return  tv show recommendation when the response code is 200',
        () async {
      //arrage

      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$testId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_recommendations.json'), 200));
      // act

      final result = await tvSeriesRemoteDataImpl.getTvSeriesRecommend(testId);
      //assert

      expect(result, equals(testRecommendedTv));
    });

    test('should throw Server Exception when the response code is 404',
        () async {
      // arrange

      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$testId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act

      final call = tvSeriesRemoteDataImpl.getTvSeriesRecommend(testId);
      // assert

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
