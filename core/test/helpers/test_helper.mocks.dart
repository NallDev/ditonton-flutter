// Mocks generated by Mockito 5.4.4 from annotations
// in core/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i12;
import 'dart:typed_data' as _i14;

import 'package:core/core.dart' as _i19;
import 'package:core/data/datasources/movies_local_data_source.dart' as _i18;
import 'package:core/data/datasources/movies_remote_data_source.dart' as _i15;
import 'package:core/data/db/database_helper.dart' as _i6;
import 'package:core/data/models/movie_model.dart' as _i16;
import 'package:core/data/models/movie_table.dart' as _i9;
import 'package:core/data/models/series_model.dart' as _i17;
import 'package:core/domain/entities/movie.dart' as _i21;
import 'package:core/domain/repositories/movies_repository.dart' as _i5;
import 'package:core/domain/usecases/get_now_playing_movies.dart' as _i22;
import 'package:core/domain/usecases/get_now_playing_series.dart' as _i23;
import 'package:core/domain/usecases/get_popular_movies.dart' as _i24;
import 'package:core/domain/usecases/get_popular_series.dart' as _i25;
import 'package:core/domain/usecases/get_top_rated_movies.dart' as _i26;
import 'package:core/domain/usecases/get_top_rated_series.dart' as _i27;
import 'package:core/utils/failure.dart' as _i20;
import 'package:dartz/dartz.dart' as _i4;
import 'package:http/io_client.dart' as _i10;
import 'package:http/src/base_request.dart' as _i11;
import 'package:http/src/io_streamed_response.dart' as _i2;
import 'package:http/src/response.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i13;
import 'package:sqflite/sqflite.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIOStreamedResponse_0 extends _i1.SmartFake
    implements _i2.IOStreamedResponse {
  _FakeIOStreamedResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMoviesRepository_3 extends _i1.SmartFake
    implements _i5.MoviesRepository {
  _FakeMoviesRepository_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i6.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i8.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i7.Future<_i8.Database?>.value(),
      ) as _i7.Future<_i8.Database?>);

  @override
  _i7.Future<void> insertCacheTransaction(
    List<_i9.MovieTable>? movies,
    String? category,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertCacheTransaction,
          [
            movies,
            category,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCacheMovies,
          [category],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);

  @override
  _i7.Future<int> clearCache(String? category) => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [category],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);

  @override
  _i7.Future<int> insertWatchlist(_i9.MovieTable? movie) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [movie],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);

  @override
  _i7.Future<int> removeWatchlist(_i9.MovieTable? movie) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [movie],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);

  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);

  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i10.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.IOStreamedResponse> send(_i11.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i2.IOStreamedResponse>.value(_FakeIOStreamedResponse_0(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i2.IOStreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i7.Future<_i3.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i3.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i3.Response>);

  @override
  _i7.Future<_i3.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i3.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i3.Response>);

  @override
  _i7.Future<_i3.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i3.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i3.Response>);

  @override
  _i7.Future<_i3.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i3.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i3.Response>);

  @override
  _i7.Future<_i3.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i3.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i3.Response>);

  @override
  _i7.Future<_i3.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i3.Response>.value(_FakeResponse_1(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i3.Response>);

  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(_i13.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<String>);

  @override
  _i7.Future<_i14.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i14.Uint8List>.value(_i14.Uint8List(0)),
      ) as _i7.Future<_i14.Uint8List>);
}

/// A class which mocks [MoviesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRemoteDataSource extends _i1.Mock
    implements _i15.MoviesRemoteDataSource {
  MockMoviesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i16.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]),
      ) as _i7.Future<List<_i16.MovieModel>>);

  @override
  _i7.Future<List<_i16.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]),
      ) as _i7.Future<List<_i16.MovieModel>>);

  @override
  _i7.Future<List<_i16.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i16.MovieModel>>.value(<_i16.MovieModel>[]),
      ) as _i7.Future<List<_i16.MovieModel>>);

  @override
  _i7.Future<List<_i17.SeriesModel>> getNowPlayingSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingSeries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i17.SeriesModel>>.value(<_i17.SeriesModel>[]),
      ) as _i7.Future<List<_i17.SeriesModel>>);

  @override
  _i7.Future<List<_i17.SeriesModel>> getPopularSeries() => (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i17.SeriesModel>>.value(<_i17.SeriesModel>[]),
      ) as _i7.Future<List<_i17.SeriesModel>>);

  @override
  _i7.Future<List<_i17.SeriesModel>> getTopRatedSeries() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i17.SeriesModel>>.value(<_i17.SeriesModel>[]),
      ) as _i7.Future<List<_i17.SeriesModel>>);
}

/// A class which mocks [MoviesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesLocalDataSource extends _i1.Mock
    implements _i18.MoviesLocalDataSource {
  MockMoviesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<void> cacheNowPlayingMovies(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNowPlayingMovies,
          [movies],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<_i9.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedNowPlayingMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]),
      ) as _i7.Future<List<_i9.MovieTable>>);

  @override
  _i7.Future<void> cachePopularMovies(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cachePopularMovies,
          [movies],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<_i9.MovieTable>> getCachedPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPopularMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]),
      ) as _i7.Future<List<_i9.MovieTable>>);

  @override
  _i7.Future<void> cacheTopRatedMovies(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheTopRatedMovies,
          [movies],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<_i9.MovieTable>> getCachedTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedTopRatedMovies,
          [],
        ),
        returnValue: _i7.Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]),
      ) as _i7.Future<List<_i9.MovieTable>>);

  @override
  _i7.Future<void> cacheToNowPlayingSeries(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheToNowPlayingSeries,
          [movies],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<_i9.MovieTable>> getCachedNowPlayingSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedNowPlayingSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]),
      ) as _i7.Future<List<_i9.MovieTable>>);

  @override
  _i7.Future<void> cacheToPopularSeries(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheToPopularSeries,
          [movies],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<_i9.MovieTable>> getCachedPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedPopularSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]),
      ) as _i7.Future<List<_i9.MovieTable>>);

  @override
  _i7.Future<void> cacheToTopRatedSeries(List<_i9.MovieTable>? movies) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheToTopRatedSeries,
          [movies],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);

  @override
  _i7.Future<List<_i9.MovieTable>> getCachedTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCachedTopRatedSeries,
          [],
        ),
        returnValue: _i7.Future<List<_i9.MovieTable>>.value(<_i9.MovieTable>[]),
      ) as _i7.Future<List<_i9.MovieTable>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i19.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}

/// A class which mocks [MoviesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRepository extends _i1.Mock implements _i5.MoviesRepository {
  MockMoviesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingMovies,
              [],
            ),
            returnValue:
                _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                    _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
              this,
              Invocation.method(
                #getNowPlayingMovies,
                [],
              ),
            )),
          ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>
      getNowPlayingSeries() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingSeries,
              [],
            ),
            returnValue:
                _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                    _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
              this,
              Invocation.method(
                #getNowPlayingSeries,
                [],
              ),
            )),
          ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> getPopularSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularSeries,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #getPopularSeries,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> getTopRatedSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedSeries,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #getTopRatedSeries,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}

/// A class which mocks [GetNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingMovies extends _i1.Mock
    implements _i22.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MoviesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMoviesRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MoviesRepository);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}

/// A class which mocks [GetNowPlayingSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingSeries extends _i1.Mock
    implements _i23.GetNowPlayingSeries {
  MockGetNowPlayingSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MoviesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMoviesRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MoviesRepository);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularMovies extends _i1.Mock implements _i24.GetPopularMovies {
  MockGetPopularMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MoviesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMoviesRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MoviesRepository);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}

/// A class which mocks [GetPopularSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularSeries extends _i1.Mock implements _i25.GetPopularSeries {
  MockGetPopularSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MoviesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMoviesRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MoviesRepository);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}

/// A class which mocks [GetTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMovies extends _i1.Mock implements _i26.GetTopRatedMovies {
  MockGetTopRatedMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MoviesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMoviesRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MoviesRepository);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}

/// A class which mocks [GetTopRatedSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedSeries extends _i1.Mock implements _i27.GetTopRatedSeries {
  MockGetTopRatedSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MoviesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMoviesRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.MoviesRepository);

  @override
  _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>.value(
                _FakeEither_2<_i20.Failure, List<_i21.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i7.Future<_i4.Either<_i20.Failure, List<_i21.Movie>>>);
}