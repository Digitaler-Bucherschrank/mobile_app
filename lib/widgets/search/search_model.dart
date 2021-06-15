import 'dart:async';

import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/utils.dart';

class SearchModel extends ChangeNotifier {
  ApiService apiService = new ApiService();
  SearchModel() {
    loadSuggestions();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Completer _history = new Completer<List<BookCase>>();
  List<Map<dynamic, dynamic>> _suggestions = [];
  List<Map<dynamic, dynamic>> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _suggestions = await _history.future;
    } else {
      var bookCases = await getBookCases();
      var books = await apiService.searchBooks(query);
      List temp = [];
      List<Map<dynamic, dynamic>> result = [];
      for (var bookCase in bookCases) {
        if (Utilities.containsIgnoreCase(bookCase.title!, query) ||
            Utilities.containsIgnoreCase(bookCase.address ?? '', query)) {
          temp.add(bookCase);
        }
      }
      temp.addAll(books);
      for (var item in temp) {
        if (item.runtimeType == BookCase) {
          result.add({
            'title': item.title,
            'subtitle': item.address,
            'icon': "asset",
            'lat': item.lat,
            'lon': item.lon
          });
        } else {
          result.add({
            'title': item.title,
            'subtitle': item.author,
            'icon': item.thumbnail
          });
        }
      }
      //result.add(await getBook(search));
      print("result: $result");
      if (result.isNotEmpty) {
        _suggestions = result;
      } else {
        _suggestions = [];
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() async {
    _suggestions = await _history.future;
    notifyListeners();
  }

  // ignore: todo
  /// Either returns 5 random BookCases TODO: or the last 5 searched items
  void loadSuggestions() async {
    // ignore: dead_code
    if (false /* insert history check*/) {
    } else {
      var bookCases = (await getBookCases());
      List<Map<dynamic, dynamic>> bookCasesList = [];
      for (var item in bookCases) {
        bookCasesList.add(
            {'title': item.title, 'subtitle': item.address, 'icon': "asset"});
      }
      bookCasesList.shuffle();

      var trimmed = bookCasesList.sublist(0, 5);
      //_history.complete(trimmed);
      _suggestions = trimmed;
      notifyListeners();
    }
  }
}
