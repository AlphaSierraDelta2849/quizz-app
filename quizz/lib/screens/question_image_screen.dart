import 'package:flutter/material.dart';
import 'package:quizz/models/question.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizz/pages/theme_choice.dart';

class QuestionImageScreen extends StatefulWidget {
  final Question question;
  // final void Function() changeQuestion;
  final void Function(bool) incrementPoint;
  const QuestionImageScreen(
      {super.key,
      required this.question,
      // required this.changeQuestion,
      required this.incrementPoint});

  @override
  State<QuestionImageScreen> createState() => _QuestionImageScreenState();
}

class _QuestionImageScreenState extends State<QuestionImageScreen> {
  bool isButtonClicked = false;
  @override
  void initState() {
    super.initState();
    resetClickedButton();
    print(isButtonClicked);
  }

  void resetClickedButton() {
    setState(() {
      isButtonClicked = false;
    });
  }

  final ansColor = {0: Colors.blue, 1: Colors.green, 2: Colors.red};
  MaterialColor? changeColor(isClicked, index) {
    if (!isClicked) {
      return ansColor[0];
    } else {
      return widget.question.indeAns == index ? ansColor[1] : ansColor[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
    return Padding(
      // color: Colors.white,
      padding: EdgeInsets.fromLTRB(30, 0, 12, 0),
      child: Column(
        children: [
          Row(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Card(
                color: Colors.blue.shade700,
                elevation: 6,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(children: [
                      Text(
                        widget.question.intitule,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        width: 300, // Specify the desired width
                        height: 200, // Specify the desired height
                        child: Image.asset(
                          widget.question.image!,
                        ),
                      ),
                    ]),
                  ),
                )),
          ),
          SizedBox(height: 30),
          Expanded(
              child: SizedBox(
                  // height: 200.0,
                  child: ListView.builder(
                      itemCount: widget.question.options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: size.height / 32),
                          child: ElevatedButton(
                              child: Text(
                                widget.question.options[index],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize:
                                      Size.fromHeight(size.height / 16),
                                  backgroundColor: changeColor(
                                      widget.question.isButtonClicked, index),
                                  elevation: 4),
                              onPressed: isButtonClicked
                                  ? null
                                  : (() {
                                      bool trouve =
                                          widget.question.indeAns == index;
                                      setState(() {
                                        widget.question.isButtonClicked = true;
                                      });
                                      if (trouve) {
                                        Fluttertoast.showToast(
                                          msg: 'Bonne réponse!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: 'Incorrect!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor:
                                              Color.fromARGB(255, 220, 35, 35),
                                          textColor: Colors.white,
                                        );
                                      }
                                      widget.incrementPoint(trouve);
                                      // widget.changeQuestion();
                                    })),
                        );
                      }))),
        ],
      ),
    );
  }
}
