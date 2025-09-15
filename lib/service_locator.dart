import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/feature/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:movie_app/feature/home/data/datasource/home_local_datasource_impl.dart';
import 'package:movie_app/feature/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:movie_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:movie_app/feature/home/domain/usecase/home_usecase.dart';
import 'package:movie_app/feature/home/domain/usecase/movie_detail_usecase.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_cubit.dart';
import 'package:movie_app/feature/home/presentation/bloc/movie_detail_cubit.dart';
import 'package:movie_app/feature/search/data/datasource/search_remote_datasource.dart';
import 'package:movie_app/feature/search/data/repository/search_repository_impl.dart';
import 'package:movie_app/feature/search/domain/repository/search_repository.dart';
import 'package:movie_app/feature/search/domain/usecase/search_usecase.dart';
import 'package:movie_app/feature/search/presentation/bloc/search_cubit.dart';

final sl = GetIt.instance;

void init() {
  //core
  sl.registerLazySingleton(() => DioClient.createDio());
  sl.registerLazySingleton(() => ApiClient(sl()));

  //home
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeLocalDatasource>(
    () => HomeLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => HomeUsecase(sl()));

  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));

  sl.registerFactory<DashboardCubit>(() => DashboardCubit());

  sl.registerLazySingleton<MovieDetailUsecase>(
    () => MovieDetailUsecase(sl()),
  );
  sl.registerFactory<MovieDetailsCubit>(() => MovieDetailsCubit(sl()));

  //search
  sl.registerLazySingleton<SearchRemoteDatasource>(
    () => SearchRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => SearchUsecase(sl()));
  sl.registerFactory<SearchCubit>(() => SearchCubit(sl()));
}
