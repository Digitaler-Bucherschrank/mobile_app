import 'dart:async';

import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/utils.dart';

class SearchModel extends ChangeNotifier {
  SearchModel(){
    loadSuggestions();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Completer _history = new Completer<List<BookCase>>();
  List<BookCase> _suggestions = [];
  List<BookCase> get suggestions =>  _suggestions;

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
      var result = <BookCase>[];
      for(var bookCase in bookCases){
        if (Utilities.containsIgnoreCase(bookCase.title!, query) || Utilities.containsIgnoreCase(bookCase.address?? '', query)) {
          result.add(bookCase);
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

  void clear() async{
    _suggestions = await _history.future;
    notifyListeners();
  }

  /// Either returns 5 random BookCases TODO: or the last 5 searched items
  void loadSuggestions() async {
    if (false /* insert history check*/) {

    } else {
      var bookCases = (await getBookCases());
      bookCases.shuffle();

      var trimmed = bookCases.sublist(0, 5);
      _history.complete(trimmed);
      _suggestions = trimmed;
      notifyListeners();
    }
  }
}