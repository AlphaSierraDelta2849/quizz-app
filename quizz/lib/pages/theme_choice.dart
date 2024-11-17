import 'package:flutter/material.dart';
import 'package:quizz/pages/question_page.dart';
import 'package:quizz/services/jsonLoader.dart';

import '../models/theme.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);
  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  List<ThemeQ> themes = [];
  loadTheme() async {
    themes = await loadThemes();
    themes.shuffle();
    print(themes);
    setState(() {});
  }

  @override
  void initState() {
    loadTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 8,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            iconSize: 30,
          ),
          backgroundColor: Colors.blue.shade500,
          title: Text(
            'Thèmes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            Icon(
              Icons.book_outlined,
              size: 30,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: height,
          child: Center(
              child: Container(
            padding: EdgeInsets.only(top: height / 5),
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: themes.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuestionPage(
                              theme: themes[index],
                            ),
                          ),
                        );
                        // Handle button press
                        print('Button pressed: ${themes[index].filename}');
                      },
                      child: Text(
                        themes[index].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 8,
                          minimumSize: Size.fromHeight(height / 16),
                          backgroundColor: Colors.blue.shade500),
                    ));
              },
            ),
          )),
        ));
  }

  // Future<List<ThemeQ>> loadThemesAndQuestions() async {
  //   final String jsonFile =
  //       await rootBundle.loadString('lib/services/question.json');
  //   final List<dynamic> jsonList = json.decode(jsonFile);
  //   return jsonList.map((json) {
  //     return ThemeQ(
  //       nom: json['themeName'],
  //       libelle: json['themeName'],
  //       questionBank: (json['questions'] as List<dynamic>).map((q) {
  //         return Question(q['questionText'], q['correctOptionIndex'],
  //             List<String>.from(q['options']), null);
  //       }).toList(),
  //     );
  //   }).toList();
  // }
}
