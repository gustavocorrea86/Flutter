import 'package:flutter/material.dart';

class ModelPoints extends ChangeNotifier {
  double boxIsAnswered = 0;
  bool isAnswered = false;
  bool actionBtnCircle = false;
  bool actionBtnRetangulare = false;
  bool progressError = false;
  bool showBoxSubjects = false;
  int correctsCurrents;
  int incorrectsCurrents;

  ModelPoints(this.correctsCurrents, this.incorrectsCurrents);

  void actBoxAnswered(double active) {
    boxIsAnswered = active;
    notifyListeners();
  }

  void answered(bool act) {
    isAnswered = act;
    print('isAnswered $isAnswered');
    notifyListeners();
  }

  void showSubjects(bool show) {
    showBoxSubjects = show;
    notifyListeners();
  }

  void enableBtnRetangulare(bool value) {
    actionBtnRetangulare = value;
    notifyListeners();
  }

  void uptadeCorrects(int value) {
    correctsCurrents = value;
    print('correctsCurrents $correctsCurrents');
    notifyListeners();
  }

  void updateIncorrects(int value) {
    incorrectsCurrents = value;
    print('incorrectsCurrents $incorrectsCurrents');
    notifyListeners();
  }
}
