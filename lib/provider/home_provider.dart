import 'package:flutter/material.dart';
import 'package:search_image/apis/apis.dart';
import 'package:search_image/models/models.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  ImageModel? imageModel;
  List<Hit> hitList = [];
  List<Hit> favouriteList = [];

  bool isFavourite = false;

  toggleIsFavourite(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  bool autoFocus = false;
  toggleAutoFocus(bool newValue) {
    autoFocus = newValue;
    notifyListeners();
  }

  bool isLoading = false;
  bool paginationLoading = false;
  int initialPage = 1;

  toggleLoading(bool newLoading) {
    isLoading = newLoading;
    notifyListeners();
  }

  togglePaginationLoading(bool newValue) {
    paginationLoading = newValue;
    notifyListeners();
  }

  initState() {
    // listenChanges(scrollController);
    fetchImageDatas();
  }

  bool loadMoreData(ScrollNotification notification) {
    print("Notification");

    if ((notification.metrics.pixels == notification.metrics.maxScrollExtent) &&
        !paginationLoading) {
      print("I am Heree");
      if (imageModel?.total == null) {
        fetchImageDatas();
      }
    }

    return true;
  }

  Future fetchImageDatas({
    String? searchQuery,
    bool showLoading = true,
  }) async {
    // if (limit == null) {

    showLoading ? toggleLoading(true) : toggleLoading(false);
    togglePaginationLoading(true);

    var allDatas = await ApiCall.getImages(
        searchQuery: searchQuery ?? '', page: initialPage, limit: 10);

    toggleLoading(false);
    togglePaginationLoading(false);

    if (allDatas != null) {
      imageModel = allDatas;
    }

    initialPage++;
    hitList = allDatas?.hits ?? [];

    notifyListeners();
  }

  addFavouriteDatas(Hit hit) {
    favouriteList.add(hit);
    notifyListeners();
  }

  removeFavourite(Hit hit) {
    favouriteList.remove(hit);
    notifyListeners();
  }
}
