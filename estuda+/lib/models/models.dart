import 'package:flutter/material.dart';

class ModelPoints extends ChangeNotifier {
  String hits;
  String error;
  String pointsDb;
  String errorsDb;
  double boxIsAnswered = 0;
  bool isAnswered = false;
  String countAnswered;
  int index;
  String titleSchoolYears;
  String titleDisplice;
  String displiceURL;
  String schoolYearURL;
  String subject;

  ModelPoints(
      this.hits,
      this.error,
      this.pointsDb,
      this.errorsDb,
      this.countAnswered,
      this.index,
      this.titleSchoolYears,
      this.titleDisplice,
      this.displiceURL,
      this.schoolYearURL,
      this.subject);

  void pointsHits(String text) {
    hits = text;
    notifyListeners();
  }

  void errors(String text) {
    error = text;
    notifyListeners();
  }

  Future showPoints(String points) async {
    //DaoUserResum().findPoints();

    pointsDb = points;
    print('pointDb = $pointsDb');

    notifyListeners();
  }

  Future showErrors(String erros) async {
    //DaoUserResum().findErrors();
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

  void titleSchoolYear(String title) {
    titleSchoolYears = title;
    print(titleSchoolYears);
    notifyListeners();
  }

  void titleDisp(String displice) {
    titleDisplice = displice;
    notifyListeners();
  }

  void displiceUrl(String displice) {
    displiceURL = displice;
    notifyListeners();
  }

  void schoolYearUrl(String schoolYear) {
    schoolYearURL = schoolYear;
    notifyListeners();
  }

  void subjectSelect(String subjectSelected) {
    subject = subjectSelected;
    notifyListeners();
  }
}
