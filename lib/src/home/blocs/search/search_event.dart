part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchMovie extends SearchEvent {
  final String name;

  SearchMovie(this.name);

  @override
  List<Object> get props => [name];
}

class SearchNextPage extends SearchEvent {
  @override
  List<Object> get props => [];
}
