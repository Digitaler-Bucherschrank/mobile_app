import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutter/material.dart';

import 'gmap.dart';
import 'models/book_case.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String selectedTerm = "";
  FloatingSearchBarController? controller;

  Future<List<String>> search(String? search) async {
    var bookCases = await getBookCases();
    print(search);
    print("bookCases in search: $bookCases");
    List<String> result = [];
    int i = 0;
    while (i < 112) {
      if (bookCases![i].title!.contains(search!)) {
        print("bookCases[i].title: ${bookCases[i].title}");
        result.add(bookCases[i].title!);
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [GMap(), searchBarUI()],
      ),
    );
  }

  Widget searchBarUI() {
    return FloatingSearchBar(
      hint: "Search.....",
      openAxisAlignment: 0.0,
      openWidth: 600,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      leadingActions: [FloatingSearchBarAction.hamburgerToBack()],
      actions: [
        FloatingSearchBarAction(
          showIfClosed: true,
          child: CircularButton(
            icon: Icon(Icons.person),
            onPressed: () {
              print("Person pressed!");
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(),
      ],
      onQueryChanged: (query) {
        setState(() {
          selectedTerm = query;
        });
      },
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      builder: (context, transition) {
        return FutureBuilder(
          future: search(selectedTerm),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return ClipRRect(
                child: Material(
                  color: Colors.white,
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text("Lade Inhalte!"),
                    ),
                  ),
                ),
              );
            } else if (snapshot.data[0] == "Nichts gefunden!") {
              return ClipRRect(
                child: Material(
                  color: Colors.white,
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text("Nichts gefunden!"),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                height: 500,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("$index" + snapshot.data[index]);
                    return Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        child: Material(
                          color: Colors.white,
                          child: ListTile(
                            leading: Image(
                              image: AssetImage('book.png'),
                            ),
                            title: Text(snapshot.data[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
/*
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
*/