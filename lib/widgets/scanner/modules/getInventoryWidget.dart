import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/widgets/scanner/modules/popUps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

ApiService apiService = new ApiService();
Map<String, List<Book>> itemsUser = {"": []};
List itemsBookcase = [];
RefreshController _refreshControllerBorrowed =
    RefreshController(initialRefresh: false);
RefreshController _refreshControllerBookcase =
    RefreshController(initialRefresh: false);
var initialBuild = true;

void onRefreshUser() async {
  // monitor network fetch
  //await Future.delayed(Duration(milliseconds: 1000));
  itemsUser = await ApiService().getUserInventory(SharedPrefs().user);
  _refreshControllerBorrowed.refreshCompleted();
}

void onRefreshBookcase(String bookCaseID) async {
  // monitor network fetch
  //await Future.delayed(Duration(milliseconds: 1000));
  itemsBookcase = await ApiService().getBookCaseInventory(bookCaseID);
  _refreshControllerBookcase.refreshCompleted();
}

SmartRefresher _buildSmartRefresherUser(BookCase bookcase) {
  return SmartRefresher(
    enablePullDown: true,
    header: ClassicHeader(),
    controller: _refreshControllerBorrowed,
    onRefresh: onRefreshUser,
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
                  leading: itemsUser['borrowed']![index].thumbnail != null
                      ? Image.network(itemsUser['borrowed']![index].thumbnail!)
                      : Icon(Icons.book),
                  title: Text(itemsUser['borrowed']![index].title!),
                  trailing: ElevatedButton(
                    child: Text(S.of(context).label_dropbook),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UserPopUp(
                            book: itemsUser['borrowed']![index],
                            bookCase: bookcase,
                          );
                        },
                      ).then((value) => onRefreshUser());
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

SmartRefresher _buildSmartRefresherBookcase(String bookCaseID) {
  return SmartRefresher(
    enablePullDown: true,
    header: ClassicHeader(),
    controller: _refreshControllerBookcase,
    onRefresh: () {
      onRefreshBookcase(bookCaseID);
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
                  leading: itemsBookcase[index].thumbnail != null
                      ? Image.network(itemsBookcase[index].thumbnail!)
                      : Icon(Icons.book),
                  title: Text(itemsBookcase[index].title!),
                  trailing: ElevatedButton(
                    child: Text(S.of(context).label_borrowbook),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return BookcasePopUp(
                            book: itemsBookcase[index],
                            bookCaseID: bookCaseID,
                          );
                        },
                      ).then((value) => onRefreshBookcase(bookCaseID));
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Future<Widget> getUserInventoryWidget(
    BookCase bookcase, BuildContext context) async {
  return Container(
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
            child: _buildSmartRefresherUser(bookcase),
          );
        }
      },
    ),
  );
}

Widget getBookCaseInventoryWidget(String bookCaseID, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.92,
    child: FutureBuilder(
      future: apiService.getBookCaseInventory(bookCaseID),
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
          print("snapshot.data['donated'].length: ${snapshot.data.length}");
          itemsBookcase = snapshot.data!;
          return Container(
              height: MediaQuery.of(context).size.height * 0.92,
              child: _buildSmartRefresherBookcase(bookCaseID));
        }
      },
    ),
  );
}
