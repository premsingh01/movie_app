import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/search/presentation/bloc/search_cubit.dart';
import 'package:movie_app/feature/search/presentation/bloc/search_state.dart';
import 'package:movie_app/feature/search/presentation/widget/search_movie_widget.dart';
import 'package:movie_app/service_locator.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  late SearchCubit _searchCubit;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchCubit = sl<SearchCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    _searchCubit.close();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel the previous timer if it exists
    _debounceTimer?.cancel();
    
    // If query is empty, clear search immediately
    if (query.trim().isEmpty) {
      _searchCubit.clearSearch();
      return;
    }
    
    // Set a new timer for debounced search
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query.trim());
    });
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      _searchCubit.searchMovies(query);
    }
  }

  Future<void> _onRefresh() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      _searchCubit.clearSearch();
      return;
    }
    _performSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Movies"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for movies...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? ValueListenableBuilder(
                        valueListenable: _searchController,
                        builder: (context, value, __) {
                          if(value.text.isEmpty){
                            return SizedBox.shrink();
                          }
                          return IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _searchCubit.clearSearch();
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                            );
                        }
                      )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild to show/hide clear button
                  _onSearchChanged(value);
                },
              ),
            ),
            
            // Search Results
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: BlocBuilder<SearchCubit, SearchState>(
                  bloc: _searchCubit,
                  builder: (context, state) {
                    switch (state) {
                      case SearchInitialState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 120),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Search for movies",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                        
                      case SearchLoadingState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 120),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                        
                      case SearchLoadedState():
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 13),
                          itemCount: state.movieList.length,
                          itemBuilder: (context, index) {
                            return SearchMovieWidget(
                              movie: state.movieList[index],
                            );
                          },
                        );
                        
                      case SearchEmptyState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            const SizedBox(height: 120),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.movie_filter,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No movies found for '${state.query}'",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Try a different search term",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                        
                      case SearchFailureState():
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            const SizedBox(height: 120),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Error: ${state.errorMsg}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => _performSearch(_searchController.text.trim()),
                                    child: const Text("Retry"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
