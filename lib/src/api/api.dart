import 'dart:io';

import 'package:flutter/material.dart';
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

    print('[api][getUpcoming][url]: $url');

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

  static Future<http.Response> getGenre() {
    String url;

    url = baseUrl + 'genre/movie/list?api_key=' + apiKey;

    return http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    );
  }

  static Future<http.Response> search({@required String query, int pag}) async {
    String url;

    if (pag != null) {
      url = baseUrl +
          'search/movie?api_key=' +
          apiKey +
          '&query=' +
          query +
          '&page=' +
          pag.toString() +
          '&include_adult=false';
    } else {
      url = baseUrl +
          'search/movie?api_key=' +
          apiKey +
          '&query=' +
          query +
          '&include_adult=false';
    }

    return http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    );
  }
}
