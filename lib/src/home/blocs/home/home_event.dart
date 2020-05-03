import 'package:equatable/equatable.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchNextPage extends HomeEvent {
  @override
  List<Object> get props => [];
}
