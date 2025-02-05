import 'dart:typed_data';

class ModelsUserResum {
  final String name;
  final String lastName;
  final String schoolYear;
  final String totalPoints;
  final String totalOfQuestions;
  final String totalError;
  final String idQuestions;
  final String keyword;
  final String idQuestionCorrect;
  final String idQuestionIncorrect;

  const ModelsUserResum({
    required this.name,
    required this.lastName,
    required this.schoolYear,
    required this.totalPoints,
    required this.totalOfQuestions,
    required this.totalError,
    required this.idQuestions,
    required this.keyword,
    required this.idQuestionCorrect,
    required this.idQuestionIncorrect,
    
  });
}
