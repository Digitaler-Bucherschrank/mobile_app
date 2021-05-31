import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

Widget getInventoryWidget() {
  ApiService apiService = new ApiService();
  return Container(
      width: 300,
      height: 300,
      child: FutureBuilder(
        future: apiService.getUserInventory(SharedPrefs().user),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${snapshot.data[index]}"),
                );
              },
              itemCount: snapshot.data.length,
            );
          }
        },
      )

      /*ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(title: Text("Inventarbuch $index"));
      },
    ),*/
      );
}
