import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movie_app/feature/home/data/datasource/home_local_datasource_impl.dart';
import 'package:movie_app/feature/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:movie_app/feature/home/data/model/home_model.dart';
import 'package:movie_app/feature/home/domain/entity/home_entity.dart';
import 'package:movie_app/feature/home/domain/entity/movie_details_entity.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:oxidized/oxidized.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;
  final HomeLocalDatasource localDatasource;

  const HomeRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
Future<Result<List<MovieEntity>, Err>> getMovies() async {
  final hasNet = await _hasNetwork();

  if (hasNet) {
    // Try remote API
    final remoteResult = await _fetchRemoteMovies();

    if (remoteResult.isOk()) {
      // Return remote movies directly; do not persist into bookmarks DB
      final movies = remoteResult.unwrap();
      return Result.ok(movies);
    }
  }

  // If no internet or remote failed → fallback to local DB
  final localResult = await _fetchLocalMovies();
  return localResult;
}


Future<bool> _hasNetwork() async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false; // No network at all
    }

    // Fast internet check with timeout
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 2));

    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false; // Any error treat as offline
  }
}


  Future<Result<List<Movie>, Err>> _fetchRemoteMovies() async {
    return await Result.asyncOf(() => remoteDatasource.getMovies());
  }

  Future<Result<List<Movie>, Err>> _fetchLocalMovies() async {
    return await Result.asyncOf(() => localDatasource.getMovies());
  }



  @override
  Future<Result<MovieDetailsEntity, Err>> getMovieDetails({
    required int movieId,
  }) async {
    final remoteResult = await Result.asyncOf<MovieDetailsEntity, Err>(
      () => remoteDatasource.getMovieDetails(movieId: movieId),
    );
    return remoteResult;
  }

  @override
  Future<Result<List<MovieEntity>, Err>> getTrendingMovies({int page = 1}) async {
    final hasNet = await _hasNetwork();
    if (hasNet) {
      final remoteResult = await Result.asyncOf<List<Movie>, Err>(
        () => remoteDatasource.getTrendingMovies(page: page),
      );
      return remoteResult.map<List<MovieEntity>>((value) => value);
    }
    // no local cache for trending; fallback to local generic list
    final localResult = await _fetchLocalMovies();
    return localResult.map<List<MovieEntity>>((value) => value);
  }

  @override
  Future<Result<List<MovieEntity>, Err>> getNowPlayingMovies({int page = 1}) async {
    final hasNet = await _hasNetwork();
    if (hasNet) {
      final remoteResult = await Result.asyncOf<List<Movie>, Err>(
        () => remoteDatasource.getNowPlayingMovies(page: page),
      );
      return remoteResult.map<List<MovieEntity>>((value) => value);
    }
    final localResult = await _fetchLocalMovies();
    return localResult.map<List<MovieEntity>>((value) => value);
  }
}
