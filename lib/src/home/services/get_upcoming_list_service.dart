import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tmdb_client_kobe/src/models/app_error.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';

import 'package:http/http.dart' as http;

import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/home/services/genres.dart';

class GetUpcompingListService {
  Future<Result<List<Movie>>> call({@required int page}) async {
    http.Response resp;
    List<Movie> upcomingList = [];

    try {
      resp = await API.getUpcoming(page: page);

      var respJson = json.decode(resp.body);

      List list = respJson['results'].toList();

      list.forEach(
        (movieJson) {
          List<String> gens = [];
          List ids = [];

          ids = movieJson['genre_ids'].toList();

          ids.forEach((e) {
            if (GENRES.containsKey(e)) {
              gens.add(GENRES[e]);
            }
          });

          try {
            upcomingList.add(
              Movie.fromJson(
                movieJson,
                genres: gens,
              ),
            );
          } catch (error) {
            print('[ParsingError][error]: $error');
          }
        },
      );

      try {
        upcomingList.sort((a, b) {
          return -1 * a.releaseDate.compareTo(b.releaseDate);
        });
      } catch (e) {
        print('[sorting][error]: $e');
        return Failure<List<Movie>>(
          error: UnknownError(
            message: e.toString(),
          ),
        );
      }

      return Success(data: upcomingList);
    } catch (err) {
      print('[getUpcom][error]: $err ');

      return Failure<List<Movie>>(error: UnknownError(message: err.toString()));
    }
  }
}
