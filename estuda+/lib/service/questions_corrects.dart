import 'dart:convert';
import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class QuestionsCorrects {
  final String _questoesAll = dotenv.env['questoes']!;
  // todas as questões corretas
  // todas as questões corretas
  static List<Map<String, dynamic>> resultQuestionsCorrect = [];
  // lista das disciplinas corretas
  static List<String> listDisciplinesCorrect = [];
  // map das seleção de ano e assunto que recebe o jsonDecode sem repetições
  static List<dynamic> mapYearAndSubjectSelected = [];
  // map do expanded após selecionar a disciplina
  static List<Map<String, dynamic>> mapListSubAndYearCorrects = [];
  // lista auxiliar para impedir duplicidade ao mostrar os assuntos
  static List<Map<String, dynamic>> listAuxYearAndSubjectSelected = [];
  //resultado da da seleção das questões corretas
  static List<ModelQuestions> resultQuestions = [];
  static int amountPortuguesCorrects = 0;
  static int amountMatematicaCorrects = 0;
  static int amountGeografiaCorrects = 0;
  static int amountHistoriaCorrects = 0;
  static int amountCienciasCorrects = 0;
  Service service = Service();

// PEGA TODAS AS QUESTÕES RESPONDIDAS CORRETAMENTE pelo id da questão, COLOCA EM UMA LIST CENTRAL PARA PODER SERVIR COMO BASE DE CONSULTA. É CHAMADO NO CARREGAMENTO DA HOME.

// Future getQuestionsCorrects() async {
//     //List<Map<String, dynamic>> questionsCorrects = [];
//     print(DaoUserResum.listIdCorrects);
//     for (var el in DaoUserResum.listIdIncorrects) {
//       resultQuestionsCorrect.add(await service.findQuestionsAnsweredById(el));
//     }

//   }
  Future getQuestionsCorrects() async {
    resultQuestionsCorrect.clear();
    try {
      if (Service.resultAll.isNotEmpty) {
        for (var id in DaoUserResum.listIdCorrects) {
          for (var question in Service.resultAll) {
            if (question['id'] == int.parse(id)) {
              resultQuestionsCorrect.add(question);
            }
          }
        }

        print('Questões corretas recebidas com sucesso');
        //print('resultQuestionsCorrect $resultQuestionsCorrect');
      }
    } catch (err) {
      print('Erro ao buscar questões corretas: $err');
    }
  }
  Future<List<Map<String, dynamic>>> getQuestionsCorrects2() async {
    resultQuestionsCorrect.clear();
    try {
      http.Response response = await http.get(
        Uri.parse(
            'http://$_questoesAll/questao/${DaoUserResum.listIdCorrects}'),
      );
      if (response.statusCode == 200) {
        var list = await json.decode(response.body);
        for (var el in list) {
          resultQuestionsCorrect.add(el);
        }
        print('Questões incorretas recebidas com sucesso');
      } else {
        print('Erro ao buscar questões incorretas');
      }
    } catch (e) {
      print('Erro ao buscar questões incorretas: $e');
    }

    //print(resultQuestionsCorrect);
    return resultQuestionsCorrect;
  }

// PEGA AS DISCIPLINAS QUE FORAM RESPONDIDAS CORRETAMENTE ao clicar em resumo ,PARA PODER RENDERIZAR NA accumulated_right no Widget animated_button_progress.dart
  void getDisciplineOfQuestionsCorrects() {
    List<String> list = [];
    try {
      if (resultQuestionsCorrect.isNotEmpty) {
        for (var disciplines in resultQuestionsCorrect) {
          list.add(disciplines['displice']);
        }
        listDisciplinesCorrect = list.toSet().toList();
      }
    } catch (e) {
      print('Erro ao buscar disciplinas: $e');
    }
  }

  // faz a seleção dos assuntos e anos escolares selecionados sem repetição
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

  // faz a consulta das quaestões corretas pelo mapYearAndSubjectSelected
  void getResultQuestionsCorrects() {
    try {
      for (var question in resultQuestionsCorrect) {
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

  // faz a consulta para o expanted mostrar o assunto e o ano quando clica na disciplina
  void showSubjectsAndSchoolyeaCorrects(
      String discipline, List<Map<String, dynamic>> listMap) {
    Map<String, dynamic> mapYearAndSubject = {};
    List<Map<String, dynamic>> result = [];

    mapListSubAndYearCorrects.clear();

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
        mapListSubAndYearCorrects.add(listMap);
      }

      print('mapListSubAndYearCorrects $mapListSubAndYearCorrects');
    }
  }

// contador das disciplinas respondidas
  void counterDisciplineCorrects() {
    amountPortuguesCorrects = 0;
    amountMatematicaCorrects = 0;
    amountGeografiaCorrects = 0;
    amountHistoriaCorrects = 0;
    amountCienciasCorrects = 0;
    List<String> portugues = [];
    List<String> matematica = [];
    List<String> geografia = [];
    List<String> historia = [];
    List<String> ciencias = [];
    // print('matematica1 $matematica');

    for (var dis in resultQuestionsCorrect) {
      switch (dis['displice']) {
        case 'Português':
          portugues.add(dis['displice']);
          amountPortuguesCorrects = portugues.length;
          break;
        case 'Matemática':
          matematica.add(dis['displice']);
          amountMatematicaCorrects = matematica.length;
          break;
        case 'Geografia':
          geografia.add(dis['displice']);
          amountGeografiaCorrects = geografia.length;
          break;
        case 'História':
          historia.add(dis['displice']);
          amountHistoriaCorrects = historia.length;
          break;
        case 'Ciências':
          ciencias.add(dis['displice']);
          amountCienciasCorrects = ciencias.length;
      }
    }
    print('dashbord corretas');
    print('portugues $amountPortuguesCorrects');
    print('matematica $amountMatematicaCorrects');
    print('geografia $amountGeografiaCorrects');
    print('historia $amountHistoriaCorrects');
    print('ciencias $amountCienciasCorrects');
  }
}
