import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/search_service.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';

class SearchModel extends BaseViewModel {
  SearchService _searchService;
  DetailsService _detailsService;
  List<Movie> searchResult;
  List<Movie> leftList;
  List<Movie> rightList;
  String searchValue;
  bool error;
  bool initial;
  int page;
  int totalPages;

  void initModel() {
    _searchService = locator<SearchService>();
    _detailsService = locator<DetailsService>();
    error = false;
    initial = true;
    leftList = [];
    rightList = [];
    searchResult = _searchService.searchResult;
    searchValue = _searchService.isFirst ? null : _searchService?.queried;
    page = _searchService.page;
    totalPages = _searchService.totalPages;
    sliceList();
  }

  void onSearchPressed() async {
    setState(ViewState.Busy);
    initial = false;
    if (await _searchService.querySearch(query: searchValue)) {
      searchResult = _searchService.searchResult;
      totalPages = _searchService.totalPages;
      page = _searchService.page;
      sliceList();

      setState(ViewState.Idle);
    } else {
      error = true;
      setState(ViewState.Idle);
    }
  }

  void onChangeSearchValue(String val) {
    searchValue = val;
    print(searchValue);
  }

  void sliceList() {
    leftList = [];
    rightList = [];

    for (int j = 0; j < searchResult.length; j++) {
      if (j % 2 == 0) {
        leftList.add(searchResult[j]);
      } else {
        rightList.add(searchResult[j]);
      }
    }
  }

  void setDetails({Movie moviee}) {
    _detailsService.setDetailedMovie(mov: moviee);
  }

  void onPressShowMoreResults() async {
    setState(ViewState.Busy);
    page++;

    if (await _searchService.querySearch(
      query: searchValue,
      pag: page,
    )) {
      searchResult = _searchService.searchResult;
      totalPages = _searchService.totalPages;
      page = _searchService.page;
      sliceList();

      setState(ViewState.Idle);
    } else {
      error = true;
      setState(ViewState.Idle);
    }
  }
}
