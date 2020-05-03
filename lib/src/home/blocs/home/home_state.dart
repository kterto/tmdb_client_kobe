import 'package:equatable/equatable.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingUpcoming extends HomeState {
  @override
  List<Object> get props => null;
}

class LoadedUpcoming extends HomeState {
  final List<Movie> upcomingList;

  LoadedUpcoming(this.upcomingList);

  @override
  List<Object> get props => [upcomingList];
}

class FetchUpcomingError extends HomeState {
  final String message;

  FetchUpcomingError(this.message);

  @override
  List<Object> get props => [message];
}
