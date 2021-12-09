import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/modules/popUps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScannerDropForm extends StatefulWidget {
  final BookCase bookcase;

  ScannerDropForm(this.bookcase);

  @override
  _ScannerDropFormState createState() => _ScannerDropFormState(bookcase);
}

class _ScannerDropFormState extends State<ScannerDropForm> {
  BookCase bookcase;
  ApiService apiService = new ApiService();
  Map<String, List<Book>> itemsUser = {"": []};

  RefreshController _refreshControllerBorrowed =
      RefreshController(initialRefresh: false);
  _ScannerDropFormState(this.bookcase);

  void onRefreshUser(int? index) async {
    // monitor network fetch
    if (index != null) {
      setState(() {
        itemsUser["borrowed"]!.removeAt(index);
      });
    }
    var i = await ApiService().getUserInventory(SharedPrefs().user);
    setState(() {
      itemsUser = i;
    });

    _refreshControllerBorrowed.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: new Text(S.of(context).label_dropbook),
      ),
      body: SingleChildScrollView(
        child: new Container(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.92,
            child: FutureBuilder(
              future: apiService.getUserInventory(SharedPrefs().user),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                } else if (snapshot.data["borrowed"].isEmpty) {
                  return Container(
                    height: 50,
                    child: ListTile(
                      title: Text(S.of(context).label_empty_user,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  );
                } else {
                  print(
                      "snapshot.data['borrowed'].length: ${snapshot.data["borrowed"].length}");
                  itemsUser = snapshot.data!;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.92,
                    child: SmartRefresher(
                      enablePullDown: true,
                      header: ClassicHeader(),
                      controller: _refreshControllerBorrowed,
                      onRefresh: () {
                        onRefreshUser(null);
                      },
                      child: ListView.builder(
                        itemCount: itemsUser['borrowed']!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    leading: itemsUser['borrowed']![index]
                                                .thumbnail !=
                                            null
                                        ? Image.network(
                                            itemsUser['borrowed']![index]
                                                .thumbnail!)
                                        : Icon(Icons.book),
                                    title: Text(
                                        itemsUser['borrowed']![index].title!),
                                    trailing: ElevatedButton(
                                      child: Text(S.of(context).label_dropbook),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return UserPopUp(
                                              book:
                                                  itemsUser['borrowed']![index],
                                              bookCase: bookcase,
                                            );
                                          },
                                        ).then((value) => onRefreshUser(index));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
