part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearch extends SearchState {
  @override
  List<Object> get props => null;
}

class LoadedSearch extends SearchState {
  final List<Movie> searchResults;
  final int page;

  LoadedSearch({
    @required this.searchResults,
    @required this.page,
  });

  @override
  List<Object> get props => null;
}

class MovieNotFound extends SearchState {
  final String message;

  MovieNotFound(this.message);

  @override
  List<Object> get props => [message];
}

class EndOfList extends SearchState {
  final List<Movie> searchResults;
  final int page;

  EndOfList({
    @required this.searchResults,
    @required this.page,
  });

  @override
  List<Object> get props => null;
}

class Error extends SearchState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}
