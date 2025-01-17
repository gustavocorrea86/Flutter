import 'dart:typed_data';

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
      elementarySchool: Service.result[indexQuestion]['elementarySchool'],
      schoolYear: Service.result[indexQuestion]['schoolYear'],
      displice: Service.result[indexQuestion]['displice'],
      subject: Service.result[indexQuestion]['subject'],
      question: Service.result[indexQuestion]['question'],
      image: Uint8List.fromList(Service.result[indexQuestion]['image']['data'].cast<int>()),
      answer: Service.result[indexQuestion]['answer'],
      alternativeA: Service.result[indexQuestion]['alternativeA'],
      alternativeB: Service.result[indexQuestion]['alternativeB'],
      alternativeC: Service.result[indexQuestion]['alternativeC'],
      alternativeD: Service.result[indexQuestion]['alternativeD'],
    ));
  }

  void saveQuestionWrong(int indexQuestion) {
    DaoWrong().insertQuestionWrong(
      ModelQuestions(
        id: Service.result[indexQuestion]['id'].toString(),
        elementarySchool: Service.result[indexQuestion]['elementarySchool'],
        schoolYear: Service.result[indexQuestion]['schoolYear'],
        displice: Service.result[indexQuestion]['displice'],
        subject: Service.result[indexQuestion]['subject'],
        question: Service.result[indexQuestion]['question'],
        image: Uint8List.fromList(Service.result[indexQuestion]['image']['data'].cast<int>()),
        answer: Service.result[indexQuestion]['answer'],
        alternativeA: Service.result[indexQuestion]['alternativeA'],
        alternativeB: Service.result[indexQuestion]['alternativeB'],
        alternativeC: Service.result[indexQuestion]['alternativeC'],
        alternativeD: Service.result[indexQuestion]['alternativeD'],
      ),
    );
  }
}
