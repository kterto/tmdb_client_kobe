import 'dart:io';

import 'package:http/http.dart' as http;

const String apiKey = "c5850ed73901b8d268d0898a8a9d8bff";
const String baseUrl = "https://api.themoviedb.org/3/";

class API {
  static Future<http.Response> getUpcoming({int page, String region}) {
    int pag = page ?? 1;
    String url;

    if (region != null) {
      url = baseUrl +
          'movie/upcoming?api_key=' +
          apiKey +
          '&page=' +
          pag.toString() +
          '&region=' +
          region;
    } else {
      url = baseUrl +
          'movie/upcoming?api_key=' +
          apiKey +
          '&page=' +
          pag.toString();
    }

    return http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    );
  }

  static Future<http.Response> getBackDrops(int movieId) {
    String url;

    url = baseUrl + 'movie/' + movieId.toString() + '/images?api_key=' + apiKey;

    return http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    );
  }
}
