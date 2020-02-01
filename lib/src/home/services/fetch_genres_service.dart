import 'dart:convert';

import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/models/genre_model.dart';
import 'package:http/http.dart' as http;

class FetchGenresService {
  List<Genre> genresList;
  Map<int, String> genres;

  FetchGenresService() {
    genresList = [];
  }

  Future<bool> fetchGenres() async {
    http.Response resp;

    try {
      resp = await API.getGenre();
      // print(resp.body);

      var jsonResp = json.decode(resp.body);

      jsonResp['genres'].forEach((json) {
        genresList.add(Genre.fromJson(json));
      });

      print(genres);

      return true;
    } catch (err) {
      print('err: $err');
      return false;
    }
  }

  String givesGenre(id) {
    int index = genresList.indexWhere((gen) {
      return gen.id == id;
    });

    print(genresList[index].genre);

    return genresList[index].genre;
  }
}
