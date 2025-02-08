import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:http/http.dart' as http;

class QuestionsCorrects {
  final String _questoesAll = dotenv.env['questoes']!;
  static List<Map<String, dynamic>> resultQuestionsCorrect = [];
  static List<String> listDisciplinesCorrect = [];
  static List<String> listSubjectsCorrect = [];
  static List<Map<String, dynamic>> mapListSubAndYearCorrects = [];
  static List<String> listSchoolYearsCorrects = [];
  static int subjectLength = 0;

// PEGA TODAS AS QUESTÕES RESPONDIDAS CORRETAMENTE, COLOCA EM UMA LIST CENTRAL PARA PODER SRVIR COMO BASE DE CONSULTA. É CHAMADO NO CARREGAMENTO DA HOME.
  Future getQuestionsCorrects() async {
    //<List<ModelQuestions>>
    List listCorrects = [];
    http.Response response = await http.get(
      Uri.parse('http://$_questoesAll/questoes'),
    );
    try {
      if (response.statusCode == 200) {
        var list = await json.decode(response.body);
        // print(list);
        for (var id in DaoUserResum.listIdCorrects) {
          for (var question in list) {
            if (question['id'] == int.parse(id)) {
              listCorrects.add(question);
            }
          }
        }
        //print('Questões corretas recebidas com sucesso');
        for (var q in listCorrects) {
          //print('Questões corretas => $q');
          //print('tamanho da list ${listCorrects.length}');
          resultQuestionsCorrect.add(q);
        }
      }
    } catch (err) {
      //print('Erro ao buscar questões: $err');
    }

    // return List<ModelQuestions>.from(
    //   listCorrects.map(
    //     (element) {
    //       Uint8List bytesImage =
    //           Uint8List.fromList(element['image']['data'].cast<int>());
    //       element['image'] = bytesImage;
    //       resultQuestionsCorrect.add(element);
    //       return ModelQuestions.toMap(element);
    //     },
    //   ),
    // );
  }

// PEGA AS DISCIPLINAS QUE FORAM RESPONDIDAS ao clicar em resumo CORRETAMENTE,PARA PODER RENDERIZAR NA accumulated_right no Widget animated_button_progress.dart
  getDisciplineOfQuestionsCorrects() {
    List<String> list = [];
    try {
      if (resultQuestionsCorrect.isNotEmpty) {
        for (var disciplines in resultQuestionsCorrect) {
          list.add(disciplines['displice']);
        }
        listDisciplinesCorrect = list.toSet().toList();
      }
    } on Exception catch (e) {
      print('Erro ao buscar disciplinas: $e');
    }
  }

  // getSubjectsOfQuestionsCorrects(String discipline) {
  //   List<String> list = [];
  //   try {
  //     if (resultQuestionsCorrect.isNotEmpty) {
  //       for (var subjects in resultQuestionsCorrect) {
  //         if (subjects['displice'] == discipline) {
  //           list.add(subjects['subject']);
  //         }
  //       }

  //       listSubjectsCorrect = list.toSet().toList();
  //       subjectLength = listSubjectsCorrect.length;
  //       print('subjects $listSubjectsCorrect');
  //     } else {}
  //   } on Exception catch (e) {
  //     print('Erro ao buscar assuntos: $e');
  //   }
  // }

  // getListSchoolYearCorrects(String subjects) {
  //   List<String> list = [];
  //   try {
  //     if (resultQuestionsCorrect.isNotEmpty) {
  //       for (var sub in resultQuestionsCorrect) {
  //         if (sub['subject'] == subjects) {
  //           list.add(sub['schoolYear']);
  //         }
  //       }
  //       listSchoolYearsCorrects = list.toSet().toList();
  //       print('listSchoolYearsCorrects $listSchoolYearsCorrects');
  //     }
  //   } on Exception catch (e) {
  //     print('Erro ao buscar ano: $e');
  //   }
  // }

  // PEGA OS ASSUNTOS E ANOS DAS QUESTÕES CORRETAS E COLOCA EM UM MAP,PARA PODER RENDERIZAR NA accumulated_right
  // showSubjectsAndSchoolyeaCorrects(String discipline) {
  //   Map<String, dynamic> mapYearAndSubject = {};
  //   List<Map<String, dynamic>> result = [];

  //   mapListSubAndYearCorrects.clear();
  //   if (resultQuestionsCorrect.isNotEmpty) {
  //     for (var map in resultQuestionsCorrect) {
  //       if (map['displice'] == discipline) {
  //         mapYearAndSubject = {
  //           'schoolYear': map['schoolYear'],
  //           'subjects': map['subject']
  //         };
  //         result.add(mapYearAndSubject);
  //       }
  //     }
  //     // remove duplicates from the list and convert it to a Set to avoid duplicates.
  //     final jsonList = result.map((el) => jsonEncode(el)).toList();
  //     final setList = jsonList.toSet().toList();
  //     final decodeList = setList.map((el) => jsonDecode(el)).toList();

  //     for (var listMap in decodeList) {
  //       mapListSubAndYearCorrects.add(listMap);
  //     }
  //     print('mapListSubAndYear $mapListSubAndYearCorrects');
  //   }
  // }
}
