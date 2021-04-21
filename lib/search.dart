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
  bool  closeSearch = false;

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
      if (bookCases![i].title!.contains(search!)) {
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
    return new Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = Size(constraints.maxHeight, constraints.maxWidth);
              return CachingFutureBuilder<List<String>>(
                key: ValueKey(size),
                futureFactory: () => search(selectedTerm),
                builder: (BuildContext  context, AsyncSnapshot  snapshot) {
                  if (snapshot.data == null && !closeSearch) {
                    return GMap();
                  } else {
                    final fsb = FloatingSearchBar.of(context)!;
                    print(snapshot.data.length);
                    return Column(
                      children: [
                        /*OutlinedButton(
                      onPressed: () {
                        setState(() {
                          closeSearch = true;
                        });
                        print("closeSearch$closeSearch");
                      },
                      child: Text("zurück"),
                    ),*/
                        Container(
                          height: 623,
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                                top: size.height),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("$index" + snapshot.data[index]);
                              return ListTile(title: Text(snapshot.data[index]));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            },
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? 'Suchen',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller!.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller!.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller!.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller!.query);
                          selectedTerm = controller!.query;
                        });
                        controller!.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                          title: Text(
                            term,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: const Icon(Icons.history),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                deleteSearchTerm(term);
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              putSearchTermFirst(term);
                              selectedTerm = term;
                            });
                            controller!.close();
                          },
                        ),
                      )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
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