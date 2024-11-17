import 'package:flutter/material.dart';
import 'package:quizz/models/question.dart';
import 'package:quizz/models/theme.dart';
import 'package:quizz/pages/theme_choice.dart';
import 'package:quizz/screens/endScreen.dart';
import 'package:quizz/screens/quesion_screen.dart';
import 'package:quizz/screens/question_image_screen.dart';
import 'package:quizz/services/jsonLoader.dart';

class QuestionPage extends StatefulWidget {
  final ThemeQ theme;
  const QuestionPage({required this.theme, Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> questionBank = [];
  int indexQuestion = 0, totalPoint = 0;
  loadQuestionBank() async {
    questionBank = await loadQuestions(widget.theme.filename);
    questionBank.shuffle();
    print(widget.theme.filename);
    print(questionBank.length);

    setState(() {});
  }

  @override
  void initState() {
    loadQuestionBank();
    super.initState();
    // print(themes);
  }

  void snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),
        content: const Text('Vous ne pouvez plus revenir en arrière!'),
        duration: const Duration(milliseconds: 1500),
        // width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void changeQuestion(bool progress) {
    setState(() {
      if (indexQuestion < questionBank.length - 1) {
        progress
            ? indexQuestion++
            : indexQuestion == 0
                ? snackbar()
                : indexQuestion--;
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Reset settings?'),
                  content:
                      Text('Vous avez terminé le quizz. Voir les resultats'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: Text('Retour'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(this.context).push(
                        MaterialPageRoute(
                          builder: (context) => EndScreen(
                            totalPoint: totalPoint,
                          ),
                        ),
                      ),
                      child: Text('ACCEPT'),
                    ),
                  ],
                ));
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => EndScreen(
        //       totalPoint: totalPoint,
        //     ),
        //   ),
        // );
      }
    });
  }

  void incrementPoint(bool trouve) {
    setState(() {
      if (trouve) totalPoint++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return questionBank.isNotEmpty
        ? questionContainer()
        : Scaffold(body: Center(child: Text('Chargement des questions')));
  }

  Widget questionContainer() {
    bool containImage = questionBank[indexQuestion].image != "" ? true : false;
    final alertD = AlertDialog(
      title: Text('Quitter?'),
      content: Text('Vous etes sur de vouloir quitter ce quizz?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text('Retour'),
        ),
        TextButton(
          onPressed: () => Navigator.of(this.context).push(
            MaterialPageRoute(
              builder: (context) => ThemeScreen(),
            ),
          ),
          child: Text('Oui. Quitter'),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: indexQuestion == 0
              ? null
              : () {
                  changeQuestion(false);
                },
          icon: const Icon(Icons.arrow_back),
          // color: Color.fromRGBO(241, 229, 71, 1),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 1,
        title: Column(children: [
          Text(
            '${widget.theme.name}',
            style: TextStyle(color: Colors.white),
          ),
          Row(children: [
            Expanded(
                child: SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: (indexQuestion + 1) / questionBank.length,
                  minHeight: 5,
                  backgroundColor: Color.fromARGB(255, 236, 48, 48),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            )),
            Text(
              ' ${indexQuestion + 1}/${questionBank.length} ',
              style: TextStyle(fontSize: 12),
            )
          ])
        ]),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: !questionBank[indexQuestion].isButtonClicked
                ? null
                : () => changeQuestion(true),
            icon: const Icon(Icons.arrow_forward_rounded),
            // color: Color.fromRGBO(241, 229, 71, 1),
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: containImage
            ? QuestionImageScreen(
                question: questionBank[indexQuestion],
                incrementPoint: incrementPoint)
            : QuestionScreen(
                question: questionBank[indexQuestion],
                incrementPoint: incrementPoint),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showDialog(context: context, builder: ((context) => alertD)),
        tooltip: 'Arreter',
        backgroundColor: Color.fromRGBO(250, 222, 64, 1),
        elevation: 3,
        child: const Icon(Icons.cancel_sharp),
      ),
    );
  }
}
