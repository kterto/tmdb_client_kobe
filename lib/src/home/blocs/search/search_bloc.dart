import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb_client_kobe/src/home/services/search_movie_sercice.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovieService _searchMovie;
  String searchedMovie;
  int currentPage = 1;
  int totalPages;

  SearchBloc({SearchMovieService searchMovie}) : _searchMovie = searchMovie;

  @override
  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchMovie) {
      yield* _mapSearchMovieToState(event.name);
    } else if (event is SearchNextPage) {
      yield* _mapSearchNextPageToState();
    }
  }

  Stream<SearchState> _mapSearchMovieToState(String movieName) async* {
    yield LoadingSearch();

    Result<Map<String, dynamic>> searchResponse = await _searchMovie(
      page: currentPage,
      query: movieName,
    );

    searchedMovie = movieName;
    currentPage = 1;

    if (searchResponse is Success) {
      totalPages = searchResponse.data['totalPages'];

      if ((searchResponse.data['movies'])?.isNotEmpty ?? false) {
        yield LoadedSearch(
          searchResults: searchResponse.data['movies'],
          page: currentPage,
        );
      } else {
        yield MovieNotFound(movieName + ' not found');
      }
    } else {
      yield Error(searchResponse.error.message);
    }
  }

  Stream<SearchState> _mapSearchNextPageToState() async* {
    if (currentPage < totalPages) {
      currentPage++;
      yield LoadingSearch();

      Result<Map<String, dynamic>> searchResponse = await _searchMovie(
        page: currentPage,
        query: searchedMovie,
      );

      print(searchResponse);

      if (searchResponse is Success) {
        totalPages = searchResponse.data['totalPages'];

        if ((searchResponse.data['movies'])?.isNotEmpty ?? false) {
          if (currentPage == totalPages) {
            yield EndOfList(
              page: currentPage,
              searchResults: searchResponse.data['movies'],
            );
          } else {
            yield LoadedSearch(
              searchResults: searchResponse.data['movies'],
              page: currentPage,
            );
          }
        } else {
          yield Error(searchResponse.error.message);
        }
      } else {
        yield Error(searchResponse.error.message);
      }
    } else {
      yield EndOfList(
        page: null,
        searchResults: null,
      );
    }
  }
}
