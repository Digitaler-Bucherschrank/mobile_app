import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Column(
        children: [
          RichText(
            text: new TextSpan(
              children: [
                new TextSpan(
                    text:
                        "Work on this App was started in Oktober 2020 as part of the Stiftung Polytechnische Gesellschaft's Digitechnikum. During the following year the team of four mannaged to produce a working prototype. More information on the Digitechnikum can be found under following link: "),
                new TextSpan(
                    text: "digitechnikum.de",
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.dataFromString("digitechnikum.de"));
                      })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
