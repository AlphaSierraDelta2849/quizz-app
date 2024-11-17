import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quizz/pages/accueil.dart';
import 'package:quizz/pages/app.dart';
import 'package:quizz/pages/theme_choice.dart';

class EndScreen extends StatefulWidget {
  final int totalPoint;
  const EndScreen({Key? key, required this.totalPoint}) : super(key: key);

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          SizedBox(
            height: 300,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
                child: Text(
              'Vous avez obtenu ${widget.totalPoint} points',
              style: TextStyle(color: Colors.blue, fontSize: 13),
            )),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(style: BorderStyle.solid)),
            onPressed: () => Navigator.of(this.context).push(
              MaterialPageRoute(
                  builder: (context) => App(), fullscreenDialog: true),
            ),
            child: Row(
              children: [Text('Retour à l accueil'), Icon(Icons.home_outlined)],
              mainAxisSize: MainAxisSize.min,
            ),
          )
        ]),
      ),
      color: Colors.white,
    );
  }
}
