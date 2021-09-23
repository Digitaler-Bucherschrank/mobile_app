import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'login.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // TODO: Translate text into English
    List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: "Willkommen zu Digitaler Bücherschrank!",
        body: "Die offenen Bücherschränke - nun digitalisiert",
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)
        ),
        image: Center(
            child: isDarkMode ? ColorFiltered(
              colorFilter: ColorFilter.matrix([
                -1,  0,  0, 0, 255,
                0, -1,  0, 0, 255,
                0,  0, -1, 0, 255,
                0,  0,  0, 1,   0,
              ]),
              child: Image.asset("assets/intro/intro1.png", height: 300.0),
            ) : Image.asset("assets/intro/intro1.png", height: 300.0)
        ),
      ),
      PageViewModel(
        title: "Funktionsweise",
        body: "In dieser App kannst du die verschiedenen Bücherschränke deiner Stadt kompakt auf einer Karte finden. Du kannst die jeweiligen Inventare betrachten, Bücher ausleihen & Bücher spenden bzw. zurücklegen!",
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)
        ),
        image: Center(
            child: isDarkMode ? ColorFiltered(
              colorFilter: ColorFilter.matrix([
                -1,  0,  0, 0, 255,
                0, -1,  0, 0, 255,
                0,  0, -1, 0, 255,
                0,  0,  0, 1,   0,
              ]),
              child: Image.asset("assets/intro/intro2.png", height: 300.0),
            ) : Image.asset("assets/intro/intro2.png", height: 300.0)
        ),
      ),
      PageViewModel(
        title: "Sowohl offline als auch online!",
        body: "Die App kannst du sowohl offline als auch online nutzen. Ohne Internetverbindung fallen jedoch Funktionen wie das Betrachten der Inventare weg, da diese eine Internetverbindung benötigen. ",
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)
        ),
        image: Center(
            child: Image.asset("assets/intro/intro3.png", height: 300.0)
        ),
      ),
      PageViewModel(
        title: "Wir sind auf dich angewiesen!",
        body: "Diese App lebt davon, dass so viele Bücherschränkler*innen wie möglich diese nutzen, damit die bei uns verfügbaren Informationen aktuell & nützlich sind. Daher bitten wir dich: Spread the Word! Je mehr diese App nutzen, desto mehr hat jeder davon.",
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            contentMargin: EdgeInsets.all(16.0) + EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
            imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: MediaQuery.of(context).size.width * 0.05)
        ),
        image: Center(
            child: isDarkMode ? ColorFiltered(
              colorFilter: ColorFilter.matrix([
                -1,  0,  0, 0, 255,
                0, -1,  0, 0, 255,
                0,  0, -1, 0, 255,
                0,  0,  0, 1,   0,
              ]),
              child: Image.asset("assets/intro/intro4.png", height: 300.0),
            ) : Image.asset("assets/intro/intro4.png", height: 300.0)
        ),
      )
    ];



    return IntroductionScreen(
      pages: listPagesViewModel,
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      onDone: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
        SharedPrefs().finishedIntro = true;
      },
    );
  }
}
