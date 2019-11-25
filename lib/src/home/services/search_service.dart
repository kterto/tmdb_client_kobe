import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'genres.dart';

class SearchService {
  List<Movie> searchResult;
  String queried;
  int page;
  int totalPages;
  bool isFirst;
  BehaviorSubject<bool> increasedPage$;

  SearchService() {
    increasedPage$ = BehaviorSubject<bool>();
    searchResult = [];
    page = 1;
    totalPages = 1;
    queried = '';
    isFirst = true;
  }

  Future<bool> querySearch({String query, int pag}) async {
    http.Response resp;
    isFirst = false;

    if (query != queried) {
      queried = query;
      searchResult = [];
      page = 1;
    } else {
      page = pag;
    }

    try {
      resp = await API.search(query: query, pag: page);
      print(resp.statusCode);
      print(resp.body);
      var jsonResp = json.decode(resp.body);

      List list = jsonResp['results'];
      print(jsonResp['total_pages']);
      totalPages = int.parse(jsonResp['total_pages'].toString());

      list.forEach((movieJson) {
        List<String> gens = [];
        List ids = [];

        ids = movieJson['genre_ids'].toList();

        // print(ids);

        ids.forEach((e) {
          if (genres.containsKey(e)) {
            gens.add(genres[e]);
          }
        });

        try {
          searchResult.add(
            Movie.fromJson(
              movieJson,
              genres: gens,
            ),
          );
        } catch (error) {
          print('[error]: $error');
        }
      });

      try {
        searchResult.sort((a, b) {
          if (a.releaseDate == null && b.releaseDate != null) {
            print('a null');
            return -1 * DateTime.now().compareTo(b.releaseDate);
          } else if (b.releaseDate == null && a != null) {
            print('b null');
            return -1 * a.releaseDate.compareTo(DateTime.now());
          } else if (a.releaseDate == null && b.releaseDate == null) {
            print('a n b null');
            return -1 * a.releaseDate.compareTo(b.releaseDate);
          } else {
            print('neither');
            return -1 * a.releaseDate.compareTo(b.releaseDate);
          }
        });
      } catch (e) {
        print('[sorting][error]: $e');
      }

      print(searchResult.length);
      return true;
    } catch (e) {
      if (page > 1) {
        page--;
      }
      print('[querySearch][error]: $e');
      return false;
    }
  }
}
