import 'package:core/data/db/database_helper.dart';
import 'package:core/domain/repositories/movies_repository.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_now_playing_series.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_series.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_series.dart';
import 'package:core/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:core/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:core/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:core/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:core/data/repositories/movies_repository_impl.dart';
import 'package:core/data/datasources/movies_local_data_source.dart';
import 'package:core/data/datasources/movies_remote_data_source.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:detail/data/datasources/detail_local_data_source.dart';
import 'package:detail/data/datasources/detail_remote_data_source.dart';
import 'package:detail/domain/repositories/detail_repository.dart';
import 'package:detail/domain/usecases/get_movie_detail.dart';
import 'package:detail/domain/usecases/get_movie_recommendations.dart';
import 'package:detail/domain/usecases/get_series_detail.dart';
import 'package:detail/domain/usecases/get_series_recommendations.dart';
import 'package:detail/domain/usecases/get_watchlist_status.dart';
import 'package:detail/domain/usecases/remove_watchlist.dart';
import 'package:detail/domain/usecases/save_watchlist.dart';
import 'package:detail/presentation/bloc/detail_bloc.dart';
import 'package:detail/data/repositories/detail_repository_impl.dart';
import 'package:detail/presentation/bloc/detail_watchlist_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:core/core.dart';
import 'package:search/data/datasources/search_remote_data_source.dart';
import 'package:search/data/repositories/search_repository_impl.dart';
import 'package:search/domain/repositories/search_repository.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';

final locator = GetIt.instance;

Future<void>  init() async {
  // provider
  locator.registerFactory(
    () => NowPlayingMoviesBloc(getNowPlayingMovies: locator()),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => NowPlayingSeriesBloc(getNowPlayingSeries: locator()),
  );
  locator.registerFactory(
    () => PopularSeriesBloc(getPopularSeries: locator()),
  );
  locator.registerFactory(
    () => TopRatedSeriesBloc(getTopRatedSeries: locator()),
  );
  locator.registerFactory(
    () => DetailBloc(
      getMovieDetail: locator(),
      getSeriesDetail: locator(),
      getMovieRecommendations: locator(),
      getSeriesRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailWatchlistBloc(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(() => SearchBloc(
        locator(),
      ));
  locator.registerFactory(
    () => WatchlistBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<DetailRepository>(
    () => DetailRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(localDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl());
  locator.registerLazySingleton<MoviesLocalDataSource>(
      () => MoviesLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerSingletonAsync<DetailRemoteDataSource>(
        () async => await DetailRemoteDataSourceImpl.create());
  locator.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl());
  locator.registerLazySingleton<DetailLocalDataSource>(
      () => DetailLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());

  await locator.allReady();
}
