import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';

// class ModelQuiz {
//   final String pergunta;
//   final String resposta;
//   final List<String> alternativas;

//   ModelQuiz(
//     this.pergunta,
//     this.resposta,
//     this.alternativas,
//   );

//   Map<String, dynamic> toMap() {
//     return {
//       'pergunta': pergunta,
//       'resposta': resposta,
//       'alternativas': alternativas,
//     };
//   }
// }

// class Model {
//   final String pergunta;
//   final String resposta;
//   final List<String> alternativas;

//   Model({
//     required this.pergunta,
//     required this.resposta,
//     required this.alternativas,
//   });

//   Model.fromMap(Map<String, dynamic> map)
//       : pergunta = map['pergunta'],
//         resposta = map['resposta'],
//         alternativas = map['alternativas'];

//   static List<Model> fromMaps(List maps) {
//     return maps.map((map) {
//       return Model.fromMap(map);
//     }).toList();
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'pergunta': pergunta,
//       'resposta': resposta,
//       'alternativas': alternativas,
//     };
//   }
// }

class ModelPoints extends ChangeNotifier {
  String hits;
  String error;
  String pointsDb;
  double boxIsAnswered = 0;
  bool isAnswered = false;
  ModelPoints(this.hits, this.error, this.pointsDb);

  void pointsHits(String text) {
    hits = text;
    notifyListeners();
  }

  void errors(String text) {
    error = text;
    notifyListeners();
  }

  Future showPoints(String points) async {
    DaoUserResum().findPoints();

    int aux = int.parse(points) + 1;
    pointsDb = aux.toString();

    notifyListeners();
  }

  void actBoxAnswered(double active) {
    boxIsAnswered = active;
    notifyListeners();
  }

  void answered(bool act) {
    isAnswered = act;
    notifyListeners();
  }
}
