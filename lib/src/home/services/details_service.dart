import 'package:tmdb_client_kobe/src/models/movie_model.dart';

class DetailsService {
  Movie detailedMovie;

  void setDetailedMovie({Movie mov}) {
    detailedMovie = mov;
  }
}
