import 'dart:convert';

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

  Color corAlternativa = Colors.white;
  double heightBoxIsAnswered = 0;
  static List<dynamic> idsAnswer = [];
  static List<dynamic> idsAnswerCorrect = [];
  static List<dynamic> idsAnswerIncorrect = [];

  double heightContainer = 0;
  double widthContainer = 0;

  void updateIds(
      String newId,
      List<dynamic> idLast,
      List<dynamic> currentId,
      // ignore: use_function_type_syntax_for_parameters
      Function updateId(idLast)) {
    if (currentId.isEmpty) {
      idsAnswer.add(newId);
      database.updateIdQuestions(idLast);
    } else {
      idLast = currentId;
      idLast.add(newId);
      updateId(idLast);
      ;
    }
    print('idsQuestions $idLast');
  }

  void isCorrect(bool isAnswered, String response, String alternative,
      int indexQuestion, BuildContext context, String idQuestion) {
    // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DE TODAS QUESTÕES 
    if (DaoUserResum.listId.isEmpty) {
      idsAnswer.add(idQuestion);
      database.updateIdQuestions(idsAnswer);
    } else {
      idsAnswer = DaoUserResum.listId;
      idsAnswer.add(idQuestion);
      database.updateIdQuestions(idsAnswer);
      ;
    }
    print('idsQuestions ${DaoUserResum.listId}');
    if (isAnswered) {
      heightBoxIsAnswered = 30;
    } else {
      if (response == alternative) {
        corAlternativa = Colors.green;
        //hitOrErr = 'Acertou!';
        widthContainer = 70;
        heightContainer = 20;
         // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DAS QUESTÕES CORRETAS
        if (DaoUserResum.listIdCorrects.isEmpty) {
          idsAnswerCorrect.add(idQuestion);
          database.updateIdQuestionsCorrect(idsAnswerCorrect);
        } else {
          idsAnswerCorrect = DaoUserResum.listIdCorrects;
          idsAnswerCorrect.add(idQuestion);
          database.updateIdQuestionsCorrect(idsAnswerCorrect);
          ;
        }
        //print('idsQuestions ${DaoUserResum.listId}');
        //idsAnswerCorrect = idQuestion;
        //saveQuestions.saveQuestionRight(indexQuestion);
        counterPoints.countPoints();
        counterPoints.updatePoints();
        Provider.of<ModelPoints>(context, listen: false)
            .showPoints(counterPoints.currentPoint);
        answeredsQuestions.answereds();
        Provider.of<ModelPoints>(context, listen: false)
            .counterOfAnswereds(answeredsQuestions.currentAnswered);
      } else {
        corAlternativa = Colors.red;
        //hitOrErr = 'Errou';
        widthContainer = 70;
        heightContainer = 20;
       // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DAS QUESTÕES INCORRETAS
        if (DaoUserResum.listIdIncorrect.isEmpty) {
          idsAnswerIncorrect.add(idQuestion);
          database.updateIdQuestionsIncorrect(idsAnswerIncorrect);
        } else {
          idsAnswerIncorrect = DaoUserResum.listIdIncorrect;
          idsAnswerIncorrect.add(idQuestion);
          database.updateIdQuestionsIncorrect(idsAnswerIncorrect);
          ;
        }
        // print('idsQuestions ${DaoUserResum.listId}');
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
