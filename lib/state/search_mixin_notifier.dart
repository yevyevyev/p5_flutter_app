import 'package:flutter/material.dart';

mixin SearchMixin<T> on ChangeNotifier {
  final searchTextController = TextEditingController();

  void addSearchHandler(List<T> Function(String) searchCallback) {
    searchTextController.addListener(() {
      isSearch = searchTextController.text.isNotEmpty;
      if (isSearch) {
        searchResults = searchCallback(searchTextController.text);
        notifyListeners();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  var isSearch = false;
  List<T> searchResults = [];
}
