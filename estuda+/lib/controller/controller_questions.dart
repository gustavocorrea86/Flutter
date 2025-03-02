import 'package:flutter/material.dart';
import 'package:estudamais/controller/answereds_quetions.dart';
import 'package:estudamais/controller/counter_errors.dart';
import 'package:estudamais/controller/counter_points.dart';
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
    }

    print('ids das questões respondidas - ${DaoUserResum.listId}');
    if (Provider.of<ModelPoints>(listen: false, context).isAnswered) {
      // abre o alerta que a questão ja foi respondida
      heightBoxIsAnswered = 30;
    } else {
      if (response == alternative) {
        // muda a cor do box alternativa para verde
        corAlternativa = Colors.green;

        // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DAS QUESTÕES CORRETAS
        if (DaoUserResum.listIdCorrects.isEmpty) {
          //se não tiver nenhuma respondida, vai pegar o id da questão que foi respondida, colocar em uma list, vai mandar essa list como parametro para atualizar
          idsAnswerCorrect.add(idQuestion);
          database.updateIdQuestionsCorrect(idsAnswerCorrect);
        } else {
          idsAnswerCorrect = DaoUserResum.listIdCorrects;
          idsAnswerCorrect.add(idQuestion);
          database.updateIdQuestionsCorrect(idsAnswerCorrect);
        }
        // contador de pontos
        counterPoints.countPoints();
        // atualiza os pontos
        counterPoints.updatePoints();
        Provider.of<ModelPoints>(context, listen: false)
            .showPoints(counterPoints.currentPoint);
        answeredsQuestions.answereds();

        Provider.of<ModelPoints>(context, listen: false)
            .counterOfAnswereds(answeredsQuestions.currentAnswered);
        DaoUserResum().removeIdQuestionsIncorrects(idQuestion);
      } else {
        corAlternativa = Colors.red;

        // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DAS QUESTÕES INCORRETAS
        if (DaoUserResum.listIdIncorrects.isEmpty) {
          idsAnswerIncorrect.add(idQuestion);
          database.updateIdQuestionsIncorrect(idsAnswerIncorrect);
        } else {
          idsAnswerIncorrect = DaoUserResum.listIdIncorrects;

          idsAnswerIncorrect.add(idQuestion);
          database.updateIdQuestionsIncorrect(idsAnswerIncorrect);
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
