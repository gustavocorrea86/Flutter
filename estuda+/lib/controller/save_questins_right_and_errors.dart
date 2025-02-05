// import 'dart:typed_data';

// import 'package:estudamais/database/dao_ritgh.dart';
// import 'package:estudamais/database/dao_wrong.dart';
// import 'package:estudamais/models/model_questions.dart';
// import 'package:estudamais/service/service.dart';

// class SaveQuestionsRightAndErrors {
//   DaoRight databaseRight = DaoRight();
//   DaoWrong databaseWrong = DaoWrong();

//   void saveQuestionRight(int indexQuestion) {
//     databaseRight.insertQuestionRight(ModelQuestions(
//       id: Service.resultController[indexQuestion]['id'].toString(),
//       elementarySchool: Service.resultController[indexQuestion]['elementarySchool'],
//       schoolYear: Service.resultController[indexQuestion]['schoolYear'],
//       displice: Service.resultController[indexQuestion]['displice'],
//       subject: Service.resultController[indexQuestion]['subject'],
//       question: Service.resultController[indexQuestion]['question'],
//       image: Uint8List.fromList(Service.resultController[indexQuestion]['image'].cast<int>()),
//       answer: Service.resultController[indexQuestion]['answer'],
//       alternativeA: Service.resultController[indexQuestion]['alternativeA'],
//       alternativeB: Service.resultController[indexQuestion]['alternativeB'],
//       alternativeC: Service.resultController[indexQuestion]['alternativeC'],
//       alternativeD: Service.resultController[indexQuestion]['alternativeD'],
//     ));
//   }

//   void saveQuestionWrong(int indexQuestion) {
//     DaoWrong().insertQuestionWrong(
//       ModelQuestions(
//         id: Service.resultController[indexQuestion]['id'].toString(),
//         elementarySchool: Service.resultController[indexQuestion]['elementarySchool'],
//         schoolYear: Service.resultController[indexQuestion]['schoolYear'],
//         displice: Service.resultController[indexQuestion]['displice'],
//         subject: Service.resultController[indexQuestion]['subject'],
//         question: Service.resultController[indexQuestion]['question'],
//         image: Uint8List.fromList(Service.resultController[indexQuestion]['image'].cast<int>()),
//         answer: Service.resultController[indexQuestion]['answer'],
//         alternativeA: Service.resultController[indexQuestion]['alternativeA'],
//         alternativeB: Service.resultController[indexQuestion]['alternativeB'],
//         alternativeC: Service.resultController[indexQuestion]['alternativeC'],
//         alternativeD: Service.resultController[indexQuestion]['alternativeD'],
//       ),
//     );
//   }
// }
