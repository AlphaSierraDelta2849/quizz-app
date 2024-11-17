import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quizz/models/theme.dart';

import '../models/question.dart';

Future<List<ThemeQ>> loadThemes() async {
  final String jsonFile =
      await rootBundle.loadString('lib/services/themes/themes.json');
  final List<dynamic> jsonList = json.decode(jsonFile);

  return jsonList.map((json) {
    return ThemeQ(name: json['name'], filename: json['filename']);
  }).toList();
}

Future<List<Question>> loadQuestions(String filename) async {
  final String jsonFile =
      await rootBundle.loadString('lib/services/questions/$filename.json');
  final List<dynamic> jsonList = json.decode(jsonFile);

  return jsonList.map((json) {
    return Question(
        json['questionText'],
        json['correctOptionIndex'],
        List<String>.from(json['options']),
        json['image'] != "" ? json['image'] : "");
  }).toList();
}
