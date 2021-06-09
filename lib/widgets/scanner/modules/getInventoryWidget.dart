import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<Widget> getUserInventoryWidget(String bookCaseID) async {
  ApiService apiService = new ApiService();
  List bookCases = await getBookCases();
  BookCase bookcase = bookCases[109];
  for (int i = 0; i < bookCases.length; i++) {
    if (bookCases[i].iId!.oid == bookCaseID) {
      bookcase = bookCases[i];
      i = bookCases.length;
    }
  }

  return FutureBuilder(
    future: apiService.getUserInventory(SharedPrefs().user),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.data == null) {
        return Container(
          height: 50,
          child: ListTile(
            title: Text(S.of(context).label_loading,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        );
      } else if (snapshot.data["donated"].isEmpty &&
          snapshot.data["borrowed"].isEmpty) {
        print(
            "snapshot.data['donated'].length: ${snapshot.data["donated"].length}");
        print(
            "snapshot.data['borrowed'].length: ${snapshot.data["borrowed"].length}");
        return Container(
          height: 50,
          child: ListTile(
            title: Text(S.of(context).label_empty_user,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        );
      } else {
        print(
            "snapshot.data['donated'].length: ${snapshot.data["donated"].length}");
        print(
            "snapshot.data['borrowed'].length: ${snapshot.data["borrowed"].length}");
        List userInventory =
            snapshot.data["donated"] + snapshot.data["borrowed"];
        return Container(
          height: 600,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: ListTile(
                  title: Text("${userInventory[index].title}",
                      style: Theme.of(context).textTheme.bodyText1),
                  subtitle: Text(
                    "${userInventory[index].author}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey.shade600),
                  ),
                  trailing: ElevatedButton(
                    child: Text(S.of(context).label_dropbook),
                    onPressed: () {
                      apiService.returnBook(userInventory[index], bookcase);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            itemCount: userInventory.length,
          ),
        );
      }
    },
  );
}

Widget getBookCaseInventoryWidget(String bookCaseID) {
  ApiService apiService = new ApiService();
  return Container(
    height: 600,
    child: FutureBuilder(
      future: apiService.getBookCaseInventory(bookCaseID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: ListTile(
              title: Text(S.of(context).label_loading,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          );
        } else if (snapshot.data.isEmpty) {
          print("snapshot.data['donated'].length: ${snapshot.data.length}");
          return Container(
            child: ListTile(
              title: Text(S.of(context).label_empty_bookcase,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          );
        } else {
          print("snapshot.data['donated'].length: ${snapshot.data.length}");
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: ListTile(
                  title: Text("${snapshot.data[index].title}",
                      style: Theme.of(context).textTheme.bodyText1),
                  subtitle: Text(
                    "${snapshot.data[index].author}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey.shade600),
                  ),
                  trailing: ElevatedButton(
                    child: Text(S.of(context).label_borrowbook),
                    onPressed: () {
                      apiService.borrowBook(snapshot.data[index]);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            itemCount: snapshot.data.length,
          );
        }
      },
    ),
  );
}
