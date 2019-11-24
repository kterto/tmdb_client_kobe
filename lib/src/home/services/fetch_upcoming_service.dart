import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

class FetchUpcomingService {
  List<Movie> upcomingList;
  int page;

  FetchUpcomingService() {
    upcomingList = [];
    page = 1;
  }

  Future<bool> getUpcom() async {
    http.Response resp;

    try {
      resp = await API.getUpcoming(page: page);
      // print(resp.body);

      var respJson = json.decode(resp.body);

      List list = respJson['results'].toList();

      list.forEach((movieJson) {
        upcomingList.add(Movie.fromJson(movieJson));
      });

      // print(upcomingList);

      return list.isNotEmpty;
    } catch (err) {
      print('error: $err ');
      return false;
    }
  }
}
