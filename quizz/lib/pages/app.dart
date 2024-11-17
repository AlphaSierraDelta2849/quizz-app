import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizz/pages/accueil.dart';
import 'package:quizz/pages/learn.dart';
import 'package:quizz/pages/profile.dart';
import 'package:quizz/pages/theme_choice.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int pageIndex = 0;
  final screens = [Home(), ThemeScreen(), Profile(), Learn()];

  final bottomNavBarItems = <Widget>[
    Icon(
      Icons.home,
      size: 30,
      semanticLabel: 'Accueil',
    ),
    Icon(
      Icons.stars_outlined,
      semanticLabel: 'Quizz',
    ),
    Icon(
      Icons.class_rounded,
      size: 30,
      semanticLabel: 'Learn',
    ),
    Icon(
      Icons.settings_accessibility_outlined,
      size: 30,
      semanticLabel: 'Profile',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: pageIndex,
        items: bottomNavBarItems,
        backgroundColor: Colors.blue,
        onTap: (index) => setState(() => pageIndex = index),
      ),
    );
  }
}
