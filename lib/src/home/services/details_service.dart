import 'dart:convert';

import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/models/app_error.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

import 'package:http/http.dart' as http;
import 'package:tmdb_client_kobe/src/models/result.dart';

const String baseImagesUrl = "https://image.tmdb.org/t/p/original";

class GetBackDropsService {
  Future<Result<Movie>> call(Movie detailedMovie) async {
    http.Response resp;

    try {
      resp = await API.getBackDrops(detailedMovie.id);
      // print(resp.body);

      var jsonResp = json.decode(resp.body);
      List<String> backdrops = [];

      jsonResp['backdrops'].forEach((backdrop) {
        backdrops.add(baseImagesUrl + backdrop['file_path']);
      });

      return Success(
        data: detailedMovie.copyWith(
          backdropPath: backdrops,
        ),
      );
    } catch (err) {
      print('err: $err');
      return Failure<Movie>(error: UnknownError(message: err.toString()));
    }
  }
}
