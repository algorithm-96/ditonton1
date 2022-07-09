import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:core/core.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataImpl tvSeriesLocalDataImpl;
  late DatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    tvSeriesLocalDataImpl = TvSeriesLocalDataImpl(databaseHelperTvSeries: mockDatabaseHelper);
  });


  group('Get TvSeries Detail By Id', () {
    const testId = 1;

    test('should return TvSeries Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(testId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await tvSeriesLocalDataImpl.getTvSeriesById(testId);
      // assert
      expect(result, testTvDataTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(testId)).thenAnswer((_) async => null);
      // act
      final result = await tvSeriesLocalDataImpl.getTvSeriesById(testId);
      // assert
      expect(result, null);
    });
  });

  group('save watchlist tv series', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.saveWatchlistTvSeries(testTvDataTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await tvSeriesLocalDataImpl.saveWatchlistTvSeries(testTvDataTable);
      // assert
      expect(result, 'Save to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.saveWatchlistTvSeries(testTvDataTable))
          .thenThrow(Exception());
      // act
      final call = tvSeriesLocalDataImpl.saveWatchlistTvSeries(testTvDataTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.deleteWatchlistTvSeries(testTvDataTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await tvSeriesLocalDataImpl.deleteWatchlistTvSeries(testTvDataTable);
      // assert
      expect(result, 'Delete from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.deleteWatchlistTvSeries(testTvDataTable))
          .thenThrow(Exception());
      // act
      final call = tvSeriesLocalDataImpl.deleteWatchlistTvSeries(testTvDataTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await tvSeriesLocalDataImpl.getWatchlistTvSeries();
      // assert
      expect(result, [testTvDataTable]);
    });
  });
}
