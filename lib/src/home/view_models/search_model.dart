import 'package:tmdb_client_kobe/src/home/services/details_service.dart';
import 'package:tmdb_client_kobe/src/home/services/search_service.dart';
import 'package:tmdb_client_kobe/src/locator.dart';
import 'package:tmdb_client_kobe/src/models/movie_model.dart';
import 'package:tmdb_client_kobe/src/util/base_view_model.dart';
import 'package:tmdb_client_kobe/src/util/form_control.dart';

class SearchModel extends BaseViewModel {
  SearchService _searchService;
  DetailsService _detailsService;
  FormControl<String> searchField;
  List<Movie> searchResult;
  List<Movie> leftList;
  List<Movie> rightList;
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
    // searchValue = _searchService.isFirst ? null : _searchService?.queried;
    page = _searchService.page;
    totalPages = _searchService.totalPages;
    searchField = FormControl<String>(name: 'searchField');

    // searchField.copyWith(
    //   value: _searchService.isFirst ? null : _searchService?.queried,
    // );
    sliceList();
  }

  void onSearchPressed() async {
    setState(ViewState.Busy);
    initial = false;
    if (await _searchService.querySearch(query: searchField.value)) {
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
    searchField = searchField.onChanged(val);
    print(searchField.value);
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
    if (page < totalPages) {
      setState(ViewState.Busy);

      page++;

      if (await _searchService.querySearch(
        query: searchField.value,
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
}
