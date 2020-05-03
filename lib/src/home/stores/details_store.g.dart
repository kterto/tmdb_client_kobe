// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsStore on _DetailsStoreBase, Store {
  final _$detailedMovieAtom = Atom(name: '_DetailsStoreBase.detailedMovie');

  @override
  Movie get detailedMovie {
    _$detailedMovieAtom.context.enforceReadPolicy(_$detailedMovieAtom);
    _$detailedMovieAtom.reportObserved();
    return super.detailedMovie;
  }

  @override
  set detailedMovie(Movie value) {
    _$detailedMovieAtom.context.conditionallyRunInAction(() {
      super.detailedMovie = value;
      _$detailedMovieAtom.reportChanged();
    }, _$detailedMovieAtom, name: '${_$detailedMovieAtom.name}_set');
  }

  final _$getBackdropsErrorMsgAtom =
      Atom(name: '_DetailsStoreBase.getBackdropsErrorMsg');

  @override
  String get getBackdropsErrorMsg {
    _$getBackdropsErrorMsgAtom.context
        .enforceReadPolicy(_$getBackdropsErrorMsgAtom);
    _$getBackdropsErrorMsgAtom.reportObserved();
    return super.getBackdropsErrorMsg;
  }

  @override
  set getBackdropsErrorMsg(String value) {
    _$getBackdropsErrorMsgAtom.context.conditionallyRunInAction(() {
      super.getBackdropsErrorMsg = value;
      _$getBackdropsErrorMsgAtom.reportChanged();
    }, _$getBackdropsErrorMsgAtom,
        name: '${_$getBackdropsErrorMsgAtom.name}_set');
  }

  final _$getBackdropsAsyncAction = AsyncAction('getBackdrops');

  @override
  Future<dynamic> getBackdrops() {
    return _$getBackdropsAsyncAction.run(() => super.getBackdrops());
  }

  final _$_DetailsStoreBaseActionController =
      ActionController(name: '_DetailsStoreBase');

  @override
  void setDetailedMovie(Movie initMovie) {
    final _$actionInfo = _$_DetailsStoreBaseActionController.startAction();
    try {
      return super.setDetailedMovie(initMovie);
    } finally {
      _$_DetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGetBackdropsErrorMsg(String msg) {
    final _$actionInfo = _$_DetailsStoreBaseActionController.startAction();
    try {
      return super.setGetBackdropsErrorMsg(msg);
    } finally {
      _$_DetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'detailedMovie: ${detailedMovie.toString()},getBackdropsErrorMsg: ${getBackdropsErrorMsg.toString()}';
    return '{$string}';
  }
}
