// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seach_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStoreBase, Store {
  Computed<String> _$notFoundComputed;

  @override
  String get notFound =>
      (_$notFoundComputed ??= Computed<String>(() => super.notFound)).value;

  final _$searchedMovieAtom = Atom(name: '_SearchStoreBase.searchedMovie');

  @override
  String get searchedMovie {
    _$searchedMovieAtom.context.enforceReadPolicy(_$searchedMovieAtom);
    _$searchedMovieAtom.reportObserved();
    return super.searchedMovie;
  }

  @override
  set searchedMovie(String value) {
    _$searchedMovieAtom.context.conditionallyRunInAction(() {
      super.searchedMovie = value;
      _$searchedMovieAtom.reportChanged();
    }, _$searchedMovieAtom, name: '${_$searchedMovieAtom.name}_set');
  }

  final _$searchingAtom = Atom(name: '_SearchStoreBase.searching');

  @override
  bool get searching {
    _$searchingAtom.context.enforceReadPolicy(_$searchingAtom);
    _$searchingAtom.reportObserved();
    return super.searching;
  }

  @override
  set searching(bool value) {
    _$searchingAtom.context.conditionallyRunInAction(() {
      super.searching = value;
      _$searchingAtom.reportChanged();
    }, _$searchingAtom, name: '${_$searchingAtom.name}_set');
  }

  final _$currentPageAtom = Atom(name: '_SearchStoreBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.context.enforceReadPolicy(_$currentPageAtom);
    _$currentPageAtom.reportObserved();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.context.conditionallyRunInAction(() {
      super.currentPage = value;
      _$currentPageAtom.reportChanged();
    }, _$currentPageAtom, name: '${_$currentPageAtom.name}_set');
  }

  final _$totalPagesAtom = Atom(name: '_SearchStoreBase.totalPages');

  @override
  int get totalPages {
    _$totalPagesAtom.context.enforceReadPolicy(_$totalPagesAtom);
    _$totalPagesAtom.reportObserved();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.context.conditionallyRunInAction(() {
      super.totalPages = value;
      _$totalPagesAtom.reportChanged();
    }, _$totalPagesAtom, name: '${_$totalPagesAtom.name}_set');
  }

  final _$searchedListErrorAtom =
      Atom(name: '_SearchStoreBase.searchedListError');

  @override
  String get searchedListError {
    _$searchedListErrorAtom.context.enforceReadPolicy(_$searchedListErrorAtom);
    _$searchedListErrorAtom.reportObserved();
    return super.searchedListError;
  }

  @override
  set searchedListError(String value) {
    _$searchedListErrorAtom.context.conditionallyRunInAction(() {
      super.searchedListError = value;
      _$searchedListErrorAtom.reportChanged();
    }, _$searchedListErrorAtom, name: '${_$searchedListErrorAtom.name}_set');
  }

  final _$searchedListAtom = Atom(name: '_SearchStoreBase.searchedList');

  @override
  List<Movie> get searchedList {
    _$searchedListAtom.context.enforceReadPolicy(_$searchedListAtom);
    _$searchedListAtom.reportObserved();
    return super.searchedList;
  }

  @override
  set searchedList(List<Movie> value) {
    _$searchedListAtom.context.conditionallyRunInAction(() {
      super.searchedList = value;
      _$searchedListAtom.reportChanged();
    }, _$searchedListAtom, name: '${_$searchedListAtom.name}_set');
  }

  final _$searchMovieAsyncAction = AsyncAction('searchMovie');

  @override
  Future<dynamic> searchMovie(String movieName) {
    return _$searchMovieAsyncAction.run(() => super.searchMovie(movieName));
  }

  final _$searchNextPageAsyncAction = AsyncAction('searchNextPage');

  @override
  Future<dynamic> searchNextPage() {
    return _$searchNextPageAsyncAction.run(() => super.searchNextPage());
  }

  @override
  String toString() {
    final string =
        'searchedMovie: ${searchedMovie.toString()},searching: ${searching.toString()},currentPage: ${currentPage.toString()},totalPages: ${totalPages.toString()},searchedListError: ${searchedListError.toString()},searchedList: ${searchedList.toString()},notFound: ${notFound.toString()}';
    return '{$string}';
  }
}
