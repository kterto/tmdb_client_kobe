import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb_client_kobe/src/home/services/search_movie_sercice.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';
part 'seach_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final SearchMovieService _searchMovie;

  _SearchStoreBase({@required SearchMovieService searchMovie})
      : _searchMovie = searchMovie;

  @observable
  String searchedMovie;

  @observable
  bool searching = false;

  @observable
  int currentPage = 1;

  @observable
  int totalPages;

  @observable
  String searchedListError;

  @computed
  String get notFound {
    if (searchedList != null && searchedList.isEmpty) {
      return '$searchedMovie not found!';
    } else {
      return null;
    }
  }

  @observable
  List<Movie> searchedList;
  @action
  Future searchMovie(String movieName) async {
    searching = true;
    currentPage = 1;
    Result<Map<String, dynamic>> searchResponse = await _searchMovie(
      page: currentPage,
      query: movieName,
    );

    if (searchResponse is Success) {
      searchedMovie = movieName;
      totalPages = searchResponse.data['totalPages'];
      searchedList = searchResponse.data['movies'];
      searching = false;
    } else {
      searchedListError = searchResponse.error.message;
      searching = false;
    }
  }

  @action
  Future searchNextPage() async {
    if (currentPage < totalPages) {
      searching = true;
      currentPage++;
      Result<Map<String, dynamic>> searchResponse = await _searchMovie(
        page: currentPage,
        query: searchedMovie,
      );

      if (searchResponse is Success) {
        searchedList = searchResponse.data['movies'];
        searching = false;
      } else {
        searchedListError = searchResponse.error.message;
        searching = false;
      }
    }
  }
}
