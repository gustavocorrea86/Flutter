import 'dart:async';

import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:provider/provider.dart';

class ControllerQuestions {
  DaoUserResum database = DaoUserResum();
//cor do box alternative
  Color corAlternativa = Colors.white;
  // container onde mostra questão ja respondida
  double heightBoxIsAnswered = 0;
  //atualiza id das questões respondidas
  List<dynamic> idsAnswer = [];
  //atualiza id das questões respondidas corretas
  List<dynamic> idsAnswerCorrect = [];
  //atualiza id das questões respondidas incorretas
  List<dynamic> idsAnswerIncorrect = [];

  // double heightContainer = 0;
  // double widthContainer = 0;
  Timer? timer;

  void recoverQuestionsIncorrects(
      bool isAnswered,
      String response,
      String alternative,
      int indexQuestion,
      BuildContext context,
      String idQuestion) {
    if (isAnswered) {
      // abre o alerta que a questão ja foi respondida
      heightBoxIsAnswered = 30;
    } else {
      if (response == alternative) {
        corAlternativa = Colors.green;
        timer = Timer(const Duration(seconds: 1), () {
          Provider.of<ModelPoints>(context, listen: false)
              .uptadeCorrects(DaoUserResum.listIdCorrects.length);
        });
        DaoUserResum().removeIdQuestionsIncorrects(idQuestion);
        // DaoUserResum().addIncorrectsInCorrects(idQuestion);
        if (DaoUserResum.listIdCorrects.isEmpty) {
          //se não tiver nenhuma respondida, vai pegar o id da questão que foi respondida, colocar em uma list, vai mandar essa list como parametro para atualizar
          idsAnswerCorrect.add(idQuestion);
          database.updateIdQuestionsCorrect(idsAnswerCorrect);
        } else {
          idsAnswerCorrect = DaoUserResum.listIdCorrects;
          idsAnswerCorrect.add(idQuestion);
          database.updateIdQuestionsCorrect(idsAnswerCorrect);
        }
      } else {
        corAlternativa = Colors.red;
        // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DAS QUESTÕES INCORRETAS
      }
    }
  }

  void isCorrect(bool isAnswered, String response, String alternative,
      int indexQuestion, BuildContext context, String idQuestion) {
    if (!DaoUserResum.listId.contains(idQuestion)) {
      if (DaoUserResum.listId.isEmpty) {
        idsAnswer.add(idQuestion);
        database.updateIdQuestions(idsAnswer);
      } else {
        idsAnswer = DaoUserResum.listId;
        idsAnswer.add(idQuestion);
        database.updateIdQuestions(idsAnswer);
      }
    }
    print('ids das questões respondidas - ${DaoUserResum.listId}');
    if (isAnswered) {
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
        timer = Timer(const Duration(seconds: 1), () {
          Provider.of<ModelPoints>(context, listen: false)
              .uptadeCorrects(DaoUserResum.listIdCorrects.length);
        });
        // Service.resultAll.removeWhere((el) => el['id'] == idQuestion);
        Service.resultController
            .removeWhere((el) => el['id'] == int.parse(idQuestion));
      } else {
        corAlternativa = Colors.red;
        // FAZ A VERIFICAÇÃO PARA PODER SALVAR OS IDS DAS QUESTÕES INCORRETAS
        if (DaoUserResum.listIdIncorrects.isEmpty &&
            !DaoUserResum.listIdCorrects.contains(idQuestion)) {
          idsAnswerIncorrect.add(idQuestion);
          database.updateIdQuestionsIncorrect(idsAnswerIncorrect);
        } else {
          idsAnswerIncorrect = DaoUserResum.listIdIncorrects;
          idsAnswerIncorrect.add(idQuestion);
          database.updateIdQuestionsIncorrect(idsAnswerIncorrect);
        }
        timer = Timer(const Duration(seconds: 1), () {
          Provider.of<ModelPoints>(context, listen: false)
              .updateIncorrects(DaoUserResum.listIdIncorrects.length);
        });
        // Service.resultAll.removeWhere((el) => el['id'] == idQuestion);
        Service.resultController
            .removeWhere((el) => el['id'] == int.parse(idQuestion));
      }
    }
  }
}
