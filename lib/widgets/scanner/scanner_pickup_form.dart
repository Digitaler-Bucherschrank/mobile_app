import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/modules/popUps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScannerPickupForm extends StatefulWidget {
  final BookCase bookcase;

  ScannerPickupForm(this.bookcase);

  @override
  _ScannerPickupFormState createState() => _ScannerPickupFormState(bookcase);
}

class _ScannerPickupFormState extends State<ScannerPickupForm> {
  BookCase bookcase;
  List itemsBookcase = [];
  ApiService apiService = new ApiService();
  RefreshController _refreshControllerBookcase =
      RefreshController(initialRefresh: false);
  _ScannerPickupFormState(this.bookcase);

  void onRefreshBookcase(String bookCaseID, int? index) async {
    // monitor network fetch
    print(itemsBookcase.toString());
    if (index != null) {
      setState(() {
        itemsBookcase.removeAt(index);
      });
    }
    List i = await ApiService().getBookCaseInventory(bookCaseID);
    setState(() {
      itemsBookcase = i;
    });
    print(itemsBookcase.toString());
    _refreshControllerBookcase.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: new Text(S.of(context).label_show_books),
      ),
      body: SingleChildScrollView(
        child: new Container(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.92,
            child: FutureBuilder(
              future: apiService.getBookCaseInventory(bookcase.iId!.oid!),
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
                } else {
                  print(
                      "snapshot.data['donated'].length: ${snapshot.data.length}");
                  itemsBookcase = snapshot.data!;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.92,
                    child: SmartRefresher(
                      enablePullDown: true,
                      header: ClassicHeader(),
                      controller: _refreshControllerBookcase,
                      onRefresh: () {
                        onRefreshBookcase(bookcase.iId!.oid!, null);
                      },
                      child: ListView.builder(
                        itemCount: itemsBookcase.length,
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
                                    leading:
                                        itemsBookcase[index].thumbnail != null
                                            ? Image.network(
                                                itemsBookcase[index].thumbnail!)
                                            : Icon(Icons.book),
                                    title: Text(itemsBookcase[index].title!),
                                    trailing: ElevatedButton(
                                      child:
                                          Text(S.of(context).label_borrowbook),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BookcasePopUp(
                                              book: itemsBookcase[index],
                                              bookCaseID: bookcase.iId!.oid!,
                                            );
                                          },
                                        ).then((value) => onRefreshBookcase(
                                            bookcase.iId!.oid!, index));
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
