import 'dart:convert';

import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/home/services/fetch_genres_service.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

import 'package:http/http.dart' as http;

import '../../locator.dart';

const String baseImagesUrl = "https://image.tmdb.org/t/p/original";

class DetailsService {
  Movie detailedMovie;

  void setDetailedMovie({Movie mov}) {
    detailedMovie = mov;
  }

  Future<bool> getBackDrops() async {
    http.Response resp;

    try {
      resp = await API.getBackDrops(detailedMovie.id);
      // print(resp.body);

      var jsonResp = json.decode(resp.body);
      List<String> backdrops = [];

      jsonResp['backdrops'].forEach((backdrop) {
        backdrops.add(baseImagesUrl + backdrop['file_path']);
      });

      detailedMovie = detailedMovie.copyWith(
        backdropPath: backdrops,
      );
      // detailedMovie.backdropPath = backdrops;

      print(detailedMovie.backdropPath);

      return true;
    } catch (err) {
      print('err: $err');
      return false;
    }
  }
}
