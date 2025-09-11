import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/feature/home/data/datasource/home_local_datasource_impl.dart';
import 'package:movie_app/feature/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:movie_app/feature/home/data/repository/home_repository_impl.dart';
import 'package:movie_app/feature/home/domain/repository/home_repository.dart';
import 'package:movie_app/feature/home/domain/usecase/home_usecase.dart';
import 'package:movie_app/feature/home/presentation/bloc/home_cubit.dart';
import 'package:dio/dio.dart' as dioLib;
import 'package:movie_app/feature/home/presentation/bloc/home_state.dart';
import 'package:movie_app/service_locator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {  

  @override
  initState() {    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text("Button"),
          ),
          BlocProvider(
            create: (context) => sl<HomeCubit>()..getMovies(),
            // HomeCubit(
            //   HomeUsecase(
            //     HomeRepositoryImpl(
            //       HomeRemoteDatasourceImpl(ApiClient(DioClient.createDio())),
            //       HomeLocalDatasourceImpl(),
            //     ),
            //   ),
            // )..getMovies(),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state) {
                  case HomeInitialState():
                    return SizedBox();
                  case HomeLoadingState():
                    return Center(child: CircularProgressIndicator());
                  case HomeLoadedState():
                    return Text("${state.movieData.movieList.length}");
                  case HomeFailureState():
                    return Text(state.errorMsg);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
