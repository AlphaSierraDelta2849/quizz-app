class Question {
  final String intitule;
  String? image;
  final int indeAns;
  bool isButtonClicked = false;
  final List<String> options;
  Question(String intituleQ, int answer, final List<String> opt, String? imageQ)
      : intitule = intituleQ,
        indeAns = answer,
        image = imageQ,
        options = opt;
}
