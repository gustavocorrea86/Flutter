import 'package:minha_mesada/database/dao_ritgh.dart';
import 'package:minha_mesada/database/dao_wrong.dart';
import 'package:minha_mesada/models/model_questions.dart';
import 'package:minha_mesada/service/service.dart';

class SaveQuestionsRightAndErrors {
  DaoRight databaseRight = DaoRight();
  DaoWrong databaseWrong = DaoWrong();

  void saveQuestionRight(int indexQuestion) {
    databaseRight.insertQuestionRight(ModelQuestions(
      id: Service.result[indexQuestion]['id'],
      elementarySchool: Service.result[indexQuestion]['ensino'],
      series: Service.result[indexQuestion]['serie'],
      displice: Service.result[indexQuestion]['materia'],
      subject: Service.result[indexQuestion]['assunto'],
      question: Service.result[indexQuestion]['pergunta'],
      response: Service.result[indexQuestion]['resposta'],
      alternativeA: Service.result[indexQuestion]['alternativas'][0],
      alternativeB: Service.result[indexQuestion]['alternativas'][1],
      alternativeC: Service.result[indexQuestion]['alternativas'][2],
      alternativeD: Service.result[indexQuestion]['alternativas'][3],
    ));
  }

  void saveQuestionWrong(int indexQuestion) {
    DaoWrong().insertQuestionWrong(
      ModelQuestions(
        id: Service.result[indexQuestion]['id'],
        elementarySchool: Service.result[indexQuestion]['ensino'],
        series: Service.result[indexQuestion]['serie'],
        displice: Service.result[indexQuestion]['materia'],
        subject: Service.result[indexQuestion]['assunto'],
        question: Service.result[indexQuestion]['pergunta'],
        response: Service.result[indexQuestion]['resposta'],
        alternativeA: Service.result[indexQuestion]['alternativas'][0],
        alternativeB: Service.result[indexQuestion]['alternativas'][1],
        alternativeC: Service.result[indexQuestion]['alternativas'][2],
        alternativeD: Service.result[indexQuestion]['alternativas'][3],
      ),
    );
  }
}
