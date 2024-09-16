import 'package:core/utils/network_info.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:search/data/datasources/search_remote_data_source.dart';
import 'package:search/domain/repositories/search_repository.dart';
import 'package:search/domain/usecase/search_movies.dart';

@GenerateMocks([
  IOClient,
  SearchRemoteDataSource,
  NetworkInfo,
  SearchRepository,
  SearchMovies,
])
void main() {}