// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$currentPageAtom = Atom(name: '_HomeStoreBase.currentPage');

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

  final _$upcomingListAtom = Atom(name: '_HomeStoreBase.upcomingList');

  @override
  ObservableList<Movie> get upcomingList {
    _$upcomingListAtom.context.enforceReadPolicy(_$upcomingListAtom);
    _$upcomingListAtom.reportObserved();
    return super.upcomingList;
  }

  @override
  set upcomingList(ObservableList<Movie> value) {
    _$upcomingListAtom.context.conditionallyRunInAction(() {
      super.upcomingList = value;
      _$upcomingListAtom.reportChanged();
    }, _$upcomingListAtom, name: '${_$upcomingListAtom.name}_set');
  }

  final _$getUpcomingErrorMessageAtom =
      Atom(name: '_HomeStoreBase.getUpcomingErrorMessage');

  @override
  String get getUpcomingErrorMessage {
    _$getUpcomingErrorMessageAtom.context
        .enforceReadPolicy(_$getUpcomingErrorMessageAtom);
    _$getUpcomingErrorMessageAtom.reportObserved();
    return super.getUpcomingErrorMessage;
  }

  @override
  set getUpcomingErrorMessage(String value) {
    _$getUpcomingErrorMessageAtom.context.conditionallyRunInAction(() {
      super.getUpcomingErrorMessage = value;
      _$getUpcomingErrorMessageAtom.reportChanged();
    }, _$getUpcomingErrorMessageAtom,
        name: '${_$getUpcomingErrorMessageAtom.name}_set');
  }

  final _$getUpcomingAsyncAction = AsyncAction('getUpcoming');

  @override
  Future<dynamic> getUpcoming() {
    return _$getUpcomingAsyncAction.run(() => super.getUpcoming());
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  void increasePage() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.increasePage();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGetUpcomingErrorMessage(String msg) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setGetUpcomingErrorMessage(msg);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'currentPage: ${currentPage.toString()},upcomingList: ${upcomingList.toString()},getUpcomingErrorMessage: ${getUpcomingErrorMessage.toString()}';
    return '{$string}';
  }
}
