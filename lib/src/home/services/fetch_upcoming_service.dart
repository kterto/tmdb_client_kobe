import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'package:tmdb_client_kobe/src/api/api.dart';
import 'package:tmdb_client_kobe/src/home/services/genres.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

class FetchUpcomingService {
  List<Movie> upcomingList;
  int page;
  BehaviorSubject<bool> increasedPage$;

  FetchUpcomingService() {
    upcomingList = [];
    page = 1;
    increasedPage$ = BehaviorSubject<bool>();
  }

  Future<bool> getUpcom() async {
    http.Response resp;

    try {
      resp = await API.getUpcoming(page: page);
      // print(resp.body);
      print(resp.statusCode);

      var respJson = json.decode(resp.body);
      // print(respJson['genre_ids']);
      List list = respJson['results'].toList();

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

        // print('gens: $gens');
        try {
          upcomingList.add(
            Movie.fromJson(
              movieJson,
              genres: gens,
            ),
          );
        } catch (error) {
          print('[error]: $error');
        }
      });

      upcomingList.sort((a, b) {
        return -1 * a.releaseDate.compareTo(b.releaseDate);
      });
      // print(upcomingList);
      if (upcomingList.length > 20) {
        increasedPage$.add(true);
      }
      page++;
      return list.isNotEmpty;
    } catch (err) {
      print('[getUpcom][error]: $err ');
      increasedPage$.add(false);
      return false;
    }
  }
}
