import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String email;

  DetailPage(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//Image.network(imageUrl,height: 500,),
//
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0, fontStyle: FontStyle.italic),
                    )),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //            child: Text(
                //            author,
                //           textAlign: TextAlign.justify,
                //         style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic),
                //     )),
              ],
            ),
          ),
        ));
  }
}
