import 'dart:async';

import 'package:digitaler_buecherschrank/api/api_service.dart';
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

  Completer _history = new Completer<List<Map<dynamic, dynamic>>>();
  List<Map<dynamic, dynamic>> _suggestions = [];

  List<Map<dynamic, dynamic>> get suggestions => _suggestions;

  String _query = '';

  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;

    if (query.isEmpty) {
      _suggestions = await _history.future;
    } else {
      _query = query;
      _isLoading = true;
      notifyListeners();

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
          // Only add not borrowed Books to the search (for now, until we have a working Book info view
          if ((item.location ?? "") != "") {
            result.add({
              'title': item.title,
              'subtitle': item.author,
              'icon': item.thumbnail,
              'location': bookCases.firstWhere((element) {
                print(element.iId!.oid! + " " + item.location);
                return (element.iId!.oid ?? "") == item.location;
              })
            });
          }
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

  /// Either returns 5 random BookCases TODO: or the last 5 searched items
  void loadSuggestions() async {
    // ignore: dead_code
    if (false /* insert history check*/) {
    } else {
      var bookCases = (await getBookCases());

      bookCases.shuffle();

      // Needed for darts weird conversion policy
      List<Map<String, dynamic>> convertedBookCases = [];

      bookCases.forEach((element) {
        convertedBookCases.add({
          'title': element.title,
          'subtitle': element.address,
          'icon': "asset",
          'lat': element.lat,
          'lon': element.lon,
          'icon': 'asset'
        });
      });

      var trimmed = convertedBookCases.sublist(0, 5);
      //_history.complete(trimmed);
      _suggestions = trimmed.cast<Map>();
      notifyListeners();
    }
  }
}
