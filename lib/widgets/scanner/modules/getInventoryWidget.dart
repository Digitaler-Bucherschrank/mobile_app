import 'package:flutter/material.dart';

Widget getInventoryWidget() {
  return Container(
    width: 300,
    height: 300,
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(title: Text("Inventarbuch $index"));
      },
    ),
  );
}
