import 'dart:convert';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/model_questions.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QuestionsIncorrects {
  final String _questoesAll = dotenv.env['questoes']!;
  // todas as questões corretas
  static List<Map<String, dynamic>> resultQuestionsIncorrect = [];
  // lista das disciplinas corretas
  static List<String> listDisciplinesIncorrect = [];
  // map do expanded após selecionar a disciplina
  static List<Map<String, dynamic>> mapListSubAndYearIncorrects = [];
  // map da seleção de ano e assunto que recebe o jsonDecode sem repetições
  static List<dynamic> mapYearAndSubjectSelected = [];
  // lista auxiliar para impedir duplicidade ao mostrar os assuntos
  static List<Map<String, dynamic>> listAuxYearAndSubjectSelected = [];
  //resultado da seleção das questões corretas
  static List<ModelQuestions> resultQuestions = [];
  static int amountPortuguesIncorrects = 0;
  static int amountMatematicaIncorrects = 0;
  static int amountGeografiaIncorrects = 0;
  static int amountHistoriaIncorrects = 0;
  static int amountCienciasIncorrects = 0;
  Service service = Service();

// PEGA TODAS AS QUESTÕES RESPONDIDAS CORRETAMENTE, COLOCA EM UMA LIST CENTRAL PARA PODER SRVIR COMO BASE DE CONSULTA. É CHAMADO NO CARREGAMENTO DA HOME.
  Future getQuestionsIncorrects() async {
    resultQuestionsIncorrect.clear();

    try {
      if (Service.resultAll.isNotEmpty) {
        //var list = await json.decode(response.body);

        for (var id in DaoUserResum.listIdIncorrects) {
          for (var question in Service.resultAll) {
            if (question['id'] == int.parse(id)) {
              resultQuestionsIncorrect.add(question);
            }
          }
        }
        print('Questões incorretas recebidas com sucesso');
      }
    } catch (err) {
      print('Erro ao buscar questões incorretas: $err');
    }
  }

  Future<List<Map<String, dynamic>>> getQuestionsIncorrects2() async {
    resultQuestionsIncorrect.clear();
    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://$_questoesAll/questao/${DaoUserResum.listIdIncorrects}'),
      );
      if (response.statusCode == 200) {
        var list = await json.decode(response.body);
        for (var el in list) {
          resultQuestionsIncorrect.add(el);
        }
        print('Questões incorretas recebidas com sucesso');
      } else {
        print('Erro ao buscar questões incorretas');
      }
    } catch (e) {
      print('Erro ao buscar questões incorretas: $e');
    }

    //print(resultQuestionsIncorrect);
    return resultQuestionsIncorrect;
  }

  void getQuestionsIncorrectsForSubjects(String subject) {
    try {
      for (var questions in resultQuestionsIncorrect) {
        if (questions['subject'] == subject) {
          resultQuestions.add(ModelQuestions.toMap(questions));
        }
      }
    } catch (e) {
      print('Erro ao buscar questões por assunto: $e');
    }
  }

// PEGA AS DISCIPLINAS QUE FORAM RESPONDIDAS CORRETAMENTE,PARA PODER RENDERIZAR NA accumulated_right
  void getDisciplineOfQuestionsIncorrects() {
    List<String> list = [];
    listDisciplinesIncorrect.clear();
    try {
      if (resultQuestionsIncorrect.isNotEmpty) {
        for (var disciplines in resultQuestionsIncorrect) {
          list.add(disciplines['displice']);
        }
        listDisciplinesIncorrect = list.toSet().toList();
      }
      print('listDisciplinesIncorrect $listDisciplinesIncorrect');
    } catch (e) {
      print('Erro ao buscar disciplinas: $e');
    }
  }

  void getQuestionsCorrectsForSubjects(String subjects, String schoolYear) {
    Map<String, dynamic> listMap = {};

    listMap = {
      'schoolYear': schoolYear,
      'subjects': subjects,
    };
    listAuxYearAndSubjectSelected.add(listMap);

    final listJson =
        listAuxYearAndSubjectSelected.map((el) => jsonEncode(el)).toList();
    final setList = listJson.toSet().toList();
    mapYearAndSubjectSelected = setList.map((el) => jsonDecode(el)).toList();

    print('mapYearAndSubjectSelected $mapYearAndSubjectSelected');
  }

  void getResultQuestionsIncorrects() {
    try {
      for (var question in resultQuestionsIncorrect) {
        for (var res in mapYearAndSubjectSelected) {
          if (question['subject'] == res['subjects'] &&
              question['schoolYear'] == res['schoolYear']) {
            resultQuestions.add(ModelQuestions.toMap(question));
          }
        }
      }
    } catch (e) {
      print('Erro ao buscar questões por assunto: $e');
    }
    print('resultQuestions $resultQuestions');
  }

  // PEGA OS ASSUNTOS E ANOS DAS QUESTÕES CORRETAS E COLOCA EM UM MAP,PARA PODER RENDERIZAR NA accumulated_right
  //
  void showSubjectsAndSchoolyeaIncorrects(
      String discipline, List<Map<String, dynamic>> listMap) {
    Map<String, dynamic> mapYearAndSubject = {};
    List<Map<String, dynamic>> result = [];

    mapListSubAndYearIncorrects.clear();

    if (listMap.isNotEmpty) {
      for (var map in listMap) {
        if (map['displice'] == discipline) {
          mapYearAndSubject = {
            'schoolYear': map['schoolYear'],
            'subjects': map['subject'],
            // 'lenght':
          };
          result.add(mapYearAndSubject);
        }
      }

      final jsonList = result.map((el) => jsonEncode(el)).toList();
      final setList = jsonList.toSet().toList();
      final decodeList = setList.map((el) => jsonDecode(el)).toList();

      for (var listMap in decodeList) {
        mapListSubAndYearIncorrects.add(listMap);
      }

      print('mapListSubAndYearIncorrects $mapListSubAndYearIncorrects');
    }
  }

  counterDisciplineIncorrects() {
    amountPortuguesIncorrects = 0;
    amountMatematicaIncorrects = 0;
    amountGeografiaIncorrects = 0;
    amountHistoriaIncorrects = 0;
    amountCienciasIncorrects = 0;
    List<String> portugues = [];
    List<String> matematica = [];
    List<String> geografia = [];
    List<String> historia = [];
    List<String> ciencias = [];

    for (var dis in resultQuestionsIncorrect) {
      switch (dis['displice']) {
        case 'Português':
          portugues.add(dis['displice']);
          amountPortuguesIncorrects = portugues.length;
          break;
        case 'Matemática':
          matematica.add(dis['displice']);
          amountMatematicaIncorrects = matematica.length;
          break;
        case 'Geografia':
          geografia.add(dis['displice']);
          amountGeografiaIncorrects = geografia.length;
          break;
        case 'História':
          historia.add(dis['displice']);
          amountHistoriaIncorrects = historia.length;
          break;
        case 'Ciências':
          ciencias.add(dis['displice']);
          amountCienciasIncorrects = ciencias.length;
      }
    }
    print('dashbord incorretas');
    print('portugues $amountPortuguesIncorrects');
    print('matematica $amountMatematicaIncorrects');
    print('geografia $amountGeografiaIncorrects');
    print('historia $amountHistoriaIncorrects');
    print('ciencias $amountCienciasIncorrects');
  }
}
