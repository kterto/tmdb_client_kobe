import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb_client_kobe/src/home/services/get_upcoming_list_service.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/models/result.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final GetUpcompingListService _getUpcompingList;

  _HomeStoreBase({@required GetUpcompingListService getUpcompingList})
      : _getUpcompingList = getUpcompingList;

  @observable
  int currentPage = 1;
  @action
  void increasePage() {
    currentPage++;
  }

  @observable
  ObservableList<Movie> upcomingList;
  @action
  Future getUpcoming() async {
    Result<List<Movie>> upListRes = await _getUpcompingList(page: currentPage);

    if (upListRes is Success) {
      if (upcomingList != null) {
        upcomingList = [...upcomingList, ...upListRes.data].asObservable();
        upcomingList.sort((a, b) {
          DateTime relA = a.releaseDate;
          DateTime relB = b.releaseDate;
          if (relA == null) relA = DateTime.now();
          if (relB == null) relB = DateTime.now();

          return -1 * relA.compareTo(relB);
        });
      } else {
        upcomingList = upListRes.data.asObservable();
      }
      increasePage();
    } else {
      setGetUpcomingErrorMessage(upListRes.error.message);
    }
  }

  @observable
  String getUpcomingErrorMessage;
  @action
  void setGetUpcomingErrorMessage(String msg) {
    getUpcomingErrorMessage = msg;
  }
}
