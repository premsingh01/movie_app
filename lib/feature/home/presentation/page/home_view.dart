


import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/core/network/dio_client.dart';
import 'package:movie_app/feature/home/data/datasource/home_remote_datasource_impl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}