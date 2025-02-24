import 'package:flutter/material.dart';

class ControllerAccept extends ChangeNotifier {
  bool isAccepted = false;
  double bordeCards;
  bool isBorder = false;

  ControllerAccept({this.bordeCards = 0,});

  void changeAccepted(bool value) {
    isAccepted = value;
    notifyListeners();
  }

  void changeBorderCards(double value) {
    bordeCards = value;
    notifyListeners();
  }

  void changeBorder(bool value) {
    isBorder = value;
    notifyListeners();
  }
}
