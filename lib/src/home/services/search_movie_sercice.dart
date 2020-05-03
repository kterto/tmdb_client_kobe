import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/models/app_error.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';

import 'package:http/http.dart' as http;
import 'genres.dart';

class SearchMovieService {
  Future<Result<Map<String, dynamic>>> call({
    @required int page,
    @required String query,
  }) async {
    http.Response resp;
    Map<String, dynamic> response = {
      'movies': <Movie>[],
      'totalPages': null,
    };

    try {
      resp = await API.search(query: query, pag: page);

      var jsonResp = json.decode(resp.body);

      List list = jsonResp['results'];

      response['totalPages'] = int.parse(jsonResp['total_pages'].toString());

      list.forEach((movieJson) {
        List<String> gens = [];
        List ids = [];

        ids = movieJson['genre_ids'].toList();

        ids.forEach((e) {
          if (GENRES.containsKey(e)) {
            gens.add(GENRES[e]);
          }
        });

        try {
          response['movies'].add(
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
        (response['movies'] as List<Movie>).sort((a, b) {
          if (a.releaseDate == null && b.releaseDate != null) {
            return -1 * DateTime.now().compareTo(b.releaseDate);
          } else if (b.releaseDate == null && a != null) {
            return -1 * a.releaseDate.compareTo(DateTime.now());
          } else if (a.releaseDate == null && b.releaseDate == null) {
            return -1;
          } else {
            return -1 * a.releaseDate.compareTo(b.releaseDate);
          }
        });
      } catch (e) {
        print('[sorting][error]: $e');
      }

      return Success(data: response);
    } catch (e) {
      print('[querySearch][error]: $e');
      return Failure<Map<String, dynamic>>(
        error: UnknownError(
          message: e.toString(),
        ),
      );
    }
  }
}
