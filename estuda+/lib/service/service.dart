// 1 - NO DRAWER da home, É SELECIONADO A DISCIPLINA DESEJADA, O MÉTODO getQuestionsByDiscipline BUSCA TODAS AS QUESTÕES DA DISCIPLINA SELECIONADA E ARMAZENADA NA LIST questionsByDiscipline;

// 2 - NA SCREEN schoolYear.dart, SELECIONA-SE OS ANOS DA DISCIPLINA E O MÉTODO getSubjectsOfDisciplineAndSchoolYear BUSCA TODOS OS 'ASSUNTOS' DA DISCIPLINA E DO ANO SELECIONADOS;

// 3 - NA SCREEN subject.dart, SELECIONA-SE OS ASSUNTOS DESEJADOS E O MÉTODO getQuestionsAllBySubjectsAndSchoolYear BUSCA TODAS AS QUESTÕES DO ANO E DO ASSUNTO SELECIONADOS EM questionsByDiscipline;

import 'dart:convert';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:flutter/foundation.dart';

class Service {
  final String _questoesAll = dotenv.env['questoes']!;
  static List<Map<String, dynamic>> questionsByDiscipline = [];
  static List<Map<String, dynamic>> questionsBySchoolYear = [];
  static List<String> listDisciplines = [];
  static List<String> listSelectedDisciplines = [];
  static List<String> listSelectedSchoolYear = [];
  static List<Map<String, dynamic>> resultController = [];
  ///static List<String> resultQuestionsAll = [];
  //static List<Map<String, dynamic>> listQuestionsByDipliceAndSchoolYear = [];
  //static List<String> schoolYears = [];
  static List<Map<String, dynamic>> schoolYearAndSubjects = [];
  static List<Map<String, dynamic>> resultQuestionsBySubjectsAndSchoolYear = [];

  // busca todas as questões
  Future<List<ModelQuestions>> getQuestions() async {
    List list = [];
    http.Response response = await http.get(
      Uri.parse('http://$_questoesAll/questoes'),
    );
    try {
      if (response.statusCode == 200) {
        list = await json.decode(response.body);
        print('Questões recebidas com sucesso');
        print(DaoUserResum.listId);
        List testIdCom = [];

        for (var element in list) {
          testIdCom.add(element['id']);
        }
        print('List com os ids $testIdCom');

        for (var id in DaoUserResum.listId) {
          list.removeWhere((el) => el['id'] == int.parse(id));
        }

        List testIdSem = [];
        for (var el in list) {
          testIdSem.add(el['id']);
        }
        print('List sem os ids $testIdSem');
      }
    } catch (err) {
      print('Erro ao buscar questões: $err');
    }

    return List<ModelQuestions>.from(
      list.map(
        (element) {
          Uint8List bytesImage =
              Uint8List.fromList(element['image']['data'].cast<int>());
          element['image'] = bytesImage;
          resultController.add(element);
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  // PEGA SOMENTE AS DISCIPLINAS DA BUSCA E COLOCA EM UMA LIST
  getDisplice() {
    List<String> listAux = [];
    try {
      for (var disciplines in resultController) {
        listAux.add(disciplines['displice']);
      }
      listDisciplines = listAux.toSet().toList();
      listDisciplines.sort();
      if (listDisciplines.isNotEmpty) {
        print('Disciplinas ok!: $listDisciplines');
      } else {
        print('Nenhuma disciplina encontrada!');
      }
    } on Exception catch (e) {
      print('Erro ao buscar disciplinas: $e');
    }
  }

  // BUSCA TODAS AS QUESTÕES DA DISCIPLINA SELECIONADA
  getQuestionsByDiscipline(String discipline) async {
    listSelectedDisciplines.add(discipline);
    listSelectedDisciplines.sort();

    try {
      for (var questions in resultController) {
        if (questions['displice'] == discipline) {
          questionsByDiscipline.add(questions);
        }
        //print(listSelectedDisciplines);
      }
    } on Exception catch (e) {
      print('Erro ao buscar questões por disciplina: $e');
    }
  }

  // BUSCA APENAS OS ANOS SELECIONADOS DAS DISCIPLINAS ESCOLHIDAS
  String? getSubjectsAndSchoolYearOfDiscipline(String schoolYear) {
    listSelectedSchoolYear.add(schoolYear);
    listSelectedSchoolYear.sort();
    try {
      for (var questions in questionsByDiscipline) {
        if (questionsByDiscipline.isNotEmpty) {
          if (questions['schoolYear'] == schoolYear) {
            questionsBySchoolYear.add(questions);
          }
        } else {
          print('Nenhuma questão encontrada!');
          return 'Nenhuma questão encontrada!';
        }
      }
      print('questionsBySchoolYear $questionsBySchoolYear');
    } catch (error) {
      print('Erro ao buscar questões por ano: $error');
      return 'Erro ao buscar questões por ano';
    }
    return null;
  }

  findSubjectsBySchoolYears(String years) {
    Map<String, dynamic> mapYearAndSubject = {};
    List<Map<String, dynamic>> result = [];
    try {
      for (var map in questionsBySchoolYear) {
        if (years == map['schoolYear']) {
          mapYearAndSubject = {
            'disciplines': map['displice'],
            'schoolYear': map['schoolYear'],
            'subjects': map['subject']
          };
          result.add(mapYearAndSubject);
        }
      }
      print('map $result');

      final jsonList = result.map((el) => jsonEncode(el)).toList();
      final uniqueList = jsonList.toSet().toList();
      var newMap = uniqueList.map((item) => jsonDecode(item)).toList();

      for (var listMap in newMap) {
        schoolYearAndSubjects.add(listMap);
      }
      // schoolYearAndSubjects.sort((a, b) {
      //   int compare = a['disciplines'].compereTo(a['disciplines']);
      //   if (compare != 0) {
      //     return compare;
      //   }
      // });
    } catch (err) {
      print('Falha na busca dos dados: $err');
    }
    print('Resultado: $schoolYearAndSubjects');
  }

  // BUSCA AS QUESTÕES POR ANO E ASSUNTO QUE FORAM SELECIONADAS
  // NAS TELAS ANTERIORES
  getQuestionsAllBySubjectsAndSchoolYea(
      String schoolYear, String subject, String discipline) async {
    print('schoolYear $schoolYear, subject $subject');

    try {
      if (questionsByDiscipline.isNotEmpty) {
        // BUSCA AS QUESTÕES DA DISCIPLINA SELECIONANA NO DRAWER
        var result = questionsByDiscipline
            .where((element) =>
                element['schoolYear'] == schoolYear &&
                element['subject'] == subject &&
                element['displice'] == discipline)
            .toList();
        for (var questions in result) {
          resultQuestionsBySubjectsAndSchoolYear.add(questions);
        }

        //print('result $result');
        print('resultQuestion $resultQuestionsBySubjectsAndSchoolYear');
      }
    } catch (err) {
      print('Erro ao buscar questões: $err');
    }
  }

  cleanLists() {
    questionsByDiscipline.clear();
    questionsBySchoolYear.clear();
    listSelectedDisciplines.clear();
    listSelectedSchoolYear.clear();
    resultController.clear();
    //resultQuestionsAll.clear();
    //listQuestionsByDipliceAndSchoolYear.clear();
    //schoolYears.clear();
    schoolYearAndSubjects.clear();
    resultQuestionsBySubjectsAndSchoolYear.clear();
  }
}
