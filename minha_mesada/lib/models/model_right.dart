import 'package:flutter/foundation.dart';

class ModelRight {
  String materia;
  String assunto;
  String pergunta;
  String resposta;
  String alternativaA;
  String alternativaB;
  String alternativaC;
  String alternativaD;

  ModelRight({
    required this.materia,
    required this.assunto,
    required this.pergunta,
    required this.resposta,
    required this.alternativaA,
    required this.alternativaB,
    required this.alternativaC,
    required this.alternativaD,
  });
}

class ModelNumberOfSubject extends ChangeNotifier {
  int lengthSubject;
  String assunto;
  ModelNumberOfSubject({
    required this.lengthSubject,
    required this.assunto,
  });

  void updateQtd(int qtd, String assunto) {
    lengthSubject = qtd;
    assunto = assunto;
    notifyListeners();
  }
}

class ModelLengthQuestions extends ChangeNotifier {
  int lengthQuestions;
  String subject;
  List<String> addSubject;
  ModelLengthQuestions({
    required this.lengthQuestions,
    required this.subject,
    required this.addSubject,
  });

  void addSub(String value) {
    addSubject.add(value);
    print(addSubject);
    notifyListeners();
  }
  void removeSub(String value){
    addSubject.remove(value);
    print(addSubject);
    notifyListeners();
  }
}
