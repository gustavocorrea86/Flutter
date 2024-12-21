import 'package:estudamais/database/dao_ritgh.dart';
import 'package:estudamais/database/dao_wrong.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/service/service.dart';

class SaveQuestionsRightAndErrors {
  DaoRight databaseRight = DaoRight();
  DaoWrong databaseWrong = DaoWrong();

  void saveQuestionRight(int indexQuestion) {
    databaseRight.insertQuestionRight(ModelQuestions(
      id: Service.result[indexQuestion]['id'].toString(),
      elementaryschool: Service.result[indexQuestion]['elementaryschool'],
      schoolyear: Service.result[indexQuestion]['schoolyear'],
      displice: Service.result[indexQuestion]['displice'],
      subject: Service.result[indexQuestion]['subject'],
      question: Service.result[indexQuestion]['question'],
      answer: Service.result[indexQuestion]['answer'],
      alternativeA: Service.result[indexQuestion]['alternativea'],
      alternativeB: Service.result[indexQuestion]['alternativeb'],
      alternativeC: Service.result[indexQuestion]['alternativec'],
      alternativeD: Service.result[indexQuestion]['alternatived'],
    ));
  }

  void saveQuestionWrong(int indexQuestion) {
    DaoWrong().insertQuestionWrong(
      ModelQuestions(
        id: Service.result[indexQuestion]['id'].toString(),
        elementaryschool: Service.result[indexQuestion]['elementaryschool'],
        schoolyear: Service.result[indexQuestion]['schoolyear'],
        displice: Service.result[indexQuestion]['displice'],
        subject: Service.result[indexQuestion]['subject'],
        question: Service.result[indexQuestion]['question'],
        answer: Service.result[indexQuestion]['answer'],
        alternativeA: Service.result[indexQuestion]['alternativea'],
        alternativeB: Service.result[indexQuestion]['alternativeb'],
        alternativeC: Service.result[indexQuestion]['alternativec'],
        alternativeD: Service.result[indexQuestion]['alternatived'],
      ),
    );
  }
}
