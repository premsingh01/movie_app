import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/home/presentation/widget/home_movie_widget.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_cubit.dart';
import 'package:movie_app/feature/saved/presentation/bloc/saved_state.dart';
import 'package:movie_app/service_locator.dart';
// Removed BookmarkBus; using singleton SavedCubit

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Saved")),
        body: BlocProvider.value(
          value: sl<SavedCubit>()..loadSaved(),
          child: BlocBuilder<SavedCubit, SavedState>(
            builder: (context, state) {
              switch (state) {
                case SavedInitialState():
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<SavedCubit>().loadSaved();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 120),
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                case SavedLoadingState():
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<SavedCubit>().loadSaved();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 120),
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  );
                case SavedEmptyState():
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<SavedCubit>().loadSaved();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text("No saved movies yet")),
                      ],
                    ),
                  );
                case SavedLoadedState():
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<SavedCubit>().loadSaved();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 13),
                      itemCount: state.movieList.length,
                      itemBuilder: (context, index) {
                        return HomeMovieWidget(
                          movie: state.movieList[index],
                        );
                      },
                    ),
                  );
                case SavedFailureState():
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<SavedCubit>().loadSaved();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 120),
                        Center(child: Text(state.errorMsg)),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
