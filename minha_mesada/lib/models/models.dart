import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';

class ModelPoints extends ChangeNotifier {
  String hits;
  String error;
  String pointsDb;
  String errorsDb;
  double boxIsAnswered = 0;
  bool isAnswered = false;
  String countAnswered;
  ModelPoints(this.hits, this.error, this.pointsDb, this.errorsDb, this.countAnswered);

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

    pointsDb = points;
    print('pointDb = $pointsDb');

    notifyListeners();
  }

  Future showErrors(String erros) async {
    DaoUserResum().findErrors();
    errorsDb = erros;
    print('errorsDb = $errorsDb');
  }

  void actBoxAnswered(double active) {
    boxIsAnswered = active;
    notifyListeners();
  }

  void answered(bool act) {
    isAnswered = act;
    notifyListeners();
  }

  void counterOfAnswereds(String value) {
    countAnswered = value;
    notifyListeners();
  }
}
