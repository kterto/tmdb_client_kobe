import 'package:equatable/equatable.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

abstract class DetailsState extends Equatable {}

class InitialState extends DetailsState {
  @override
  List<Object> get props => [];
}

class LoadedMovieDetails extends DetailsState {
  final Movie detailedMovie;

  LoadedMovieDetails(this.detailedMovie);

  @override
  List<Object> get props => [detailedMovie];
}

class DetailsError extends DetailsState {
  final String message;

  DetailsError(this.message);

  @override
  List<Object> get props => [message];
}
