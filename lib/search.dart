import 'dart:convert';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'gmap.dart';
import 'models/book_case.dart';

class Search extends StatefulWidget {
  @override
  _SearchState  createState() => _SearchState();
}

class _SearchState extends State<Search > {
  static const historyLength = 5;
  List<String >  _searchHistory = [];
  late List<String >  filteredSearchHistory;
  String? selectedTerm;
  FloatingSearchBarController? controller;
  bool closeSearch = false;

  List<String >  filterSearchTerms({
    @required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void deleteSearchTerm(String  term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String  term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void addSearchTerm(String  term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<List<String>>  search(String? search) async {
    var bookCases = await getBookCases();
    print("bookCases in search: $bookCases");
    List<String >  result = [];
    int  i = 0;
    while (i < 112) {
      if (bookCases[i].title!.contains(search!)) {
        print("bookCases[i].title: ${bookCases[i].title}");
        result.add("Bücherschrank: ${bookCases[i].title}");
      }
      i++;
    }
    //result.add(await getBook(search));
    print("result: $result");
    if (result.length != 0) {
      return result;
    } else {
      return ["Nichts gefunden!"];
    }
  }

  Future getBook(String  bookInfo) async {
    const _url =
        "https://test-3eea7-default-rtdb.europe-west1.firebasedatabase.app/getInfo.json";
    Map  response = await http
        .post(_url as Uri,
        body: json.encode({
          'bookInfo': bookInfo,
        }))
        .then((response) {
      Map? out = {};
      print(json.decode(response.body));
      out = json.decode(response.body);
      return out!;
    });
    return response['name'];
  }

  @override
  Widget build(BuildContext  context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      automaticallyImplyDrawerHamburger: true,
      width: isPortrait ? 600 : 500,

      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // TODO: Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: currentLocation,
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class CachingFutureBuilder<T> extends StatefulWidget {
  final Future<T> Function() futureFactory;
  final AsyncWidgetBuilder<T> builder;

  const CachingFutureBuilder(
      {Key? key, required this.futureFactory, required this.builder})
      : super(key: key);
  @override
  _CachingFutureBuilderState createState() => _CachingFutureBuilderState<T>();
}

class _CachingFutureBuilderState<T> extends State<CachingFutureBuilder<T>> {
  late Future<T> _future;

  @override
  void initState() {
    _future = widget.futureFactory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: widget.builder,
    );
  }
}

