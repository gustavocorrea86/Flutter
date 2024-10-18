import 'package:flutter/material.dart';

class ModelQuiz {
  final String pergunta;
  final String resposta;
  final List<String> alternativas;

  ModelQuiz(
    this.pergunta,
    this.resposta,
    this.alternativas,
  );

  Map<String, dynamic> toMap() {
    return {
      'pergunta': pergunta,
      'resposta': resposta,
      'alternativas': alternativas,
    };
  }
}

class Model {
  final String pergunta;
  final String resposta;
  final List<String> alternativas;

  Model({
    required this.pergunta,
    required this.resposta,
    required this.alternativas,
  });

  Model.fromMap(Map<String, dynamic> map)
      : pergunta = map['pergunta'],
        resposta = map['resposta'],
        alternativas = map['alternativas'];

  static List<Model> fromMaps(List maps) {
    return maps.map((map) {
      return Model.fromMap(map);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'pergunta': pergunta,
      'resposta': resposta,
      'alternativas': alternativas,
    };
  }
}

class ModelPoints extends ChangeNotifier {
  String hits;
  String error;
  ModelPoints(this.hits, this.error);

  void pointsHits(String text) {
    hits = text;
    notifyListeners();
  }

  void errors(String text) {
    error = text;
    notifyListeners();
  }
}
