
import 'package:core/core.dart';
import 'package:core/utils/ssl.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvSeriesRepo,
  TvSeriesLocalData,
  TvSeriesRemoteData,
  DatabaseHelper,
], customMocks: [
  MockSpec<Ssl>(as: #MockHttpClient),
])
void main() {}
