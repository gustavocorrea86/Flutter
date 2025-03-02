import 'package:flutter/material.dart';

class ModelPoints extends ChangeNotifier {
  String pointsDb;
  String errorsDb;
  double boxIsAnswered = 0;
  bool isAnswered = false;
  String countAnswered;

  bool actionBtnCircle = false;
  bool actionBtnRetangulare = false;
  bool progressError = false;
  bool showBoxSubjects = false;
  bool test;

  ModelPoints(
    this.pointsDb,
    this.errorsDb,
    this.countAnswered,
    this.actionBtnCircle,
    this.actionBtnRetangulare,
    this.test
  );

  Future showPoints(String points) async {
    //DaoUserResum().findPoints();

    pointsDb = points;
    print('pointDb = $pointsDb');

    notifyListeners();
  }

  Future showErrors(String erros) async {
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

  void showSubjects(bool show) {
    showBoxSubjects = show;
    notifyListeners();
  }

  void openBoxSubject(bool open) {
    test = open;
     notifyListeners();
  }
  void enableBtnRetangulare(bool value){
    actionBtnRetangulare = value;
    notifyListeners();
  }
}
