import 'package:flutter/material.dart';

class MyBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          //     future: fetchBooks(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].title),
                    //title: Text(_books[index].name), old vers.
                    subtitle: Text(snapshot.data[index].author),
                    //  leading: Image.network(-) ,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
