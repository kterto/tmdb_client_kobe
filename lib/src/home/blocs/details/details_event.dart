import 'package:equatable/equatable.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

abstract class DetailsEvent extends Equatable {}

class GetMovieDetails extends DetailsEvent {
  final Movie detailedMovie;

  GetMovieDetails(this.detailedMovie);

  @override
  List<Object> get props => [detailedMovie];
}
