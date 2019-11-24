import 'package:equatable/equatable.dart';

const String baseImagesUrl = "https://image.tmdb.org/t/p/original/";

class Movie extends Equatable {
  final bool hasVideo;
  final String posterPath;
  final String backdropPath;
  final String originalLang;
  final String originalTitle;
  final String title;
  final DateTime releaseDate;
  final double voteAverage;
  final String overView;
  final int id;

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
    this.hasVideo,
    this.posterPath,
    this.backdropPath,
    this.originalLang,
    this.originalTitle,
    this.title,
    this.releaseDate,
    this.voteAverage,
    this.overView,
    this.id,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : hasVideo = json['video'] ?? null,
        posterPath = baseImagesUrl + json['poster_path'] ?? null,
        backdropPath = baseImagesUrl + json['backdrop_path'] ?? null,
        originalLang = json['original_language'] ?? null,
        originalTitle = json['original_title'] ?? null,
        title = json['title'] ?? null,
        releaseDate = toDateTime(json['release_date']) ?? null,
        voteAverage = double.parse(json['vote_average'].toString()) ?? null,
        overView = json['over_view'] ?? null,
        id = json['id'] ?? null;

  @override
  String toString() {
    return '''{
      hasVideo: $hasVideo,
      posterPath: $posterPath,
      backdropPath: $backdropPath,
      originalLang: $originalLang,
      originalTitle: $originalTitle,
      title: $title,
      releaseDate: $releaseDate,
      voteAverage: $voteAverage,
      overView: $overView,
      id: $id,
    }
    ''';
  }
}

DateTime toDateTime(String date) {
  List<String> dateArray = date.split("-");
  return DateTime(
    int.parse(dateArray[0]),
    int.parse(dateArray[1]),
    int.parse(dateArray[2]),
  );
}
