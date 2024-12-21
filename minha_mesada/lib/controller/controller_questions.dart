import 'package:flutter/material.dart';
import 'package:estudamais/controller/answereds_quetions.dart';
import 'package:estudamais/controller/counter_errors.dart';
import 'package:estudamais/controller/counter_points.dart';
import 'package:estudamais/controller/save_questins_right_and_errors.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/models.dart';
import 'package:provider/provider.dart';

class ControllerQuestions {
  DaoUserResum database = DaoUserResum();
  AnsweredsQuestions answeredsQuestions = AnsweredsQuestions();
  CounterPoints counterPoints = CounterPoints();
  CounterErrors counterErrors = CounterErrors();
  SaveQuestionsRightAndErrors saveQuestions = SaveQuestionsRightAndErrors();
  Color corAlternativa = Colors.white;
  double heightBoxIsAnswered = 0;
  String hitOrErr = '';
  double heightContainer = 0;
  double widthContainer = 0;

  void isCorrect(bool isAnswered, String response, String alternative,
      int indexQuestion, BuildContext context) {
    if (isAnswered) {
      heightBoxIsAnswered = 30;
    } else {
      if (response == alternative) {
        corAlternativa = Colors.green;
        hitOrErr = 'Acertou!';
        widthContainer = 70;
        heightContainer = 20;

        saveQuestions.saveQuestionRight(indexQuestion);
        counterPoints.countPoints();
        counterPoints.updatePoints();
        Provider.of<ModelPoints>(context, listen: false)
            .showPoints(counterPoints.currentPoint);
        answeredsQuestions.answereds();
        Provider.of<ModelPoints>(context, listen: false)
            .counterOfAnswereds(answeredsQuestions.currentAnswered);
      } else {
        corAlternativa = Colors.red;
        hitOrErr = 'Errou';
        widthContainer = 70;
        heightContainer = 20;
        
        saveQuestions.saveQuestionWrong(indexQuestion);
        counterErrors.updateErrors();
        Provider.of<ModelPoints>(context, listen: false)
            .showErrors(counterErrors.currentErrors);
        counterErrors.countErrors();
        answeredsQuestions.answereds();
        Provider.of<ModelPoints>(context, listen: false)
            .counterOfAnswereds(answeredsQuestions.currentAnswered);
      }
    }
  }
}
