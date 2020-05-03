import 'package:equatable/equatable.dart';
import 'package:tmdb_client_kobe/src/home/services/genres.dart';

const String baseImagesUrl = "https://image.tmdb.org/t/p/original/";

class Movie extends Equatable {
  final String posterPath;
  final List<String> backdropPath;
  final String originalLang;
  final String originalTitle;
  final String title;
  final DateTime releaseDate;
  final double voteAverage;
  final String overView;
  final int id;
  final List<String> genre;

  @override
  List get props {
    return [
      originalLang,
      originalTitle,
      title,
      id,
    ];
  }

  Movie({
    this.posterPath,
    this.backdropPath,
    this.originalLang,
    this.originalTitle,
    this.title,
    this.releaseDate,
    this.voteAverage,
    this.overView,
    this.id,
    this.genre,
  });

  Movie.fromJson(Map<String, dynamic> json, {List<String> genres})
      : posterPath = json['poster_path'] != null
            ? baseImagesUrl + json['poster_path'].toString()
            : null,
        backdropPath = json['backdrop_path'] != null
            ? [baseImagesUrl + json['backdrop_path'].toString()]
            : [null],
        originalLang = json['original_language'].toString() ?? null,
        originalTitle = json['original_title'].toString() ?? null,
        title = json['title'].toString() ?? null,
        releaseDate = toDateTime(json['release_date']) ?? null,
        voteAverage = double.parse(json['vote_average'].toString()) ?? null,
        overView = json['overview'].toString() ?? null,
        id = int.parse(json['id'].toString()) ?? null,
        genre = genres ?? null;

  Movie copyWith({
    List<String> backdropPath,
    String posterPath,
    String originalLang,
    String originalTitle,
    String title,
    DateTime releaseDate,
    double voteAverage,
    String overView,
    int id,
    List<String> genre,
  }) {
    return Movie(
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      originalLang: originalLang ?? this.originalLang,
      originalTitle: originalTitle ?? this.originalTitle,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      overView: overView ?? this.overView,
      id: id ?? this.id,
      genre: genre ?? this.genre,
    );
  }

  @override
  String toString() {
    return '''{
      posterPath: $posterPath,
      backdropPath: $backdropPath,
      originalLang: $originalLang,
      originalTitle: $originalTitle,
      title: $title,
      releaseDate: $releaseDate,
      voteAverage: $voteAverage,
      overView: $overView,
      id: $id,
      genre: $genre,
    }
    ''';
  }
}

DateTime toDateTime(String date) {
  try {
    List<String> dateArray = date.split("-");
    return DateTime.tryParse(date);
  } catch (e) {
    print('[toDateTime][error]: $e');
    return null;
  }
}

List<String> generateGenreList({List<int> genIds}) {
  List<String> _genres = [];

  genIds.forEach((ids) {
    if (GENRES.containsKey(ids)) {
      _genres.add(GENRES[ids]);
    }
  });

  return _genres;
}
