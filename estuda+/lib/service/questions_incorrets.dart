import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:http/http.dart' as http;

class QuestionsIncorrects {
  final String _questoesAll = dotenv.env['questoes']!;
  static List<Map<String, dynamic>> resultQuestionsIncorrect = [];
  static List<String> listDisciplinesIncorrect = [];
  static List<String> listSubjectsIncorrect = [];
  static List<Map<String, dynamic>> mapListSubAndYearIncorrects = [];
  static List<String> listSchoolYearsIncorrects = [];
  static int subjectLength = 0;
  static Set<String> subjectsOfQuestionsIncorrects = {};
  static int amountPortuguesIncorrects = 0;
  static int amountMatematicaIncorrects = 0;
  static int amountGeografiaIncorrects = 0;
  static int amountHistoriaIncorrects = 0;
  static int amountCienciasIncorrects = 0;

// PEGA TODAS AS QUESTÕES RESPONDIDAS CORRETAMENTE, COLOCA EM UMA LIST CENTRAL PARA PODER SRVIR COMO BASE DE CONSULTA. É CHAMADO NO CARREGAMENTO DA HOME.
  Future<List<ModelQuestions>> getQuestionsIncorrects() async {
    List listIncorrects = [];
    resultQuestionsIncorrect.clear();
    http.Response response = await http.get(
      Uri.parse('http://$_questoesAll/questoes'),
    );
    try {
      if (response.statusCode == 200) {
        var list = await json.decode(response.body);
        // print(list);
        for (var id in DaoUserResum.listIdIncorrects) {
          for (var question in list) {
            if (question['id'] == int.parse(id)) {
              listIncorrects.add(question);
            }
          }
        }
        print('Questões incorretas recebidas com sucesso');
      }
    } catch (err) {
      print('Erro ao buscar questões incorretas: $err');
    }

    return List<ModelQuestions>.from(
      listIncorrects.map(
        (element) {
          Uint8List bytesImage =
              Uint8List.fromList(element['image']['data'].cast<int>());
          element['image'] = bytesImage;
          resultQuestionsIncorrect.add(element);
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  showSubjectsOfQuestionsIncorrects(String subject) {
    subjectsOfQuestionsIncorrects.add(subject);
    print('subjectsOfQuestionsIncorrects $subjectsOfQuestionsIncorrects');
  }

// PEGA AS DISCIPLINAS QUE FORAM RESPONDIDAS CORRETAMENTE,PARA PODER RENDERIZAR NA accumulated_right
  getDisciplineOfQuestionsIncorrects() {
    List<String> list = [];
    try {
      if (resultQuestionsIncorrect.isNotEmpty) {
        for (var disciplines in resultQuestionsIncorrect) {
          list.add(disciplines['displice']);
        }
        listDisciplinesIncorrect = list.toSet().toList();
      }
      //print('listDisciplinesIncorrect $listDisciplinesIncorrect');
    } on Exception catch (e) {
      print('Erro ao buscar disciplinas: $e');
    }
  }

  // PEGA OS ASSUNTOS E ANOS DAS QUESTÕES CORRETAS E COLOCA EM UM MAP,PARA PODER RENDERIZAR NA accumulated_right
  showSubjectsAndSchoolyearIncorrects(String discipline) {
    Map<String, dynamic> mapYearAndSubject = {};
    List<Map<String, dynamic>> result = [];
    mapListSubAndYearIncorrects.clear();
    if (resultQuestionsIncorrect.isNotEmpty) {
      for (var map in resultQuestionsIncorrect) {
        if (map['displice'] == discipline) {
          mapYearAndSubject = {
            'schoolYear': map['schoolYear'],
            'subjects': map['subject']
          };
          result.add(mapYearAndSubject);
        }
      }
      // remove duplicates from the list and convert it to a Set to avoid duplicates.
      final jsonList = result.map((el) => jsonEncode(el)).toList();
      final setList = jsonList.toSet().toList();
      final decodeList = setList.map((el) => jsonDecode(el)).toList();

      for (var listMap in decodeList) {
        mapListSubAndYearIncorrects.add(listMap);
      }
      //print('mapListSubAndYear $mapListSubAndYearIncorrects');
    }
  }

  counterDisciplineIncorrects() {
    List<String> portugues = [];
    List<String> matematica = [];
    List<String> geografia = [];
    List<String> historia = [];
    List<String> ciencias = [];
    print('matematica1 $matematica');

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
        case 'Ciências da Natureza':
          ciencias.add(dis['displice']);
          amountCienciasIncorrects = ciencias.length;
      }
    }
    print('matematica2 $matematica');
    print('portugues $amountPortuguesIncorrects');
    print('matematica $amountMatematicaIncorrects');
    print('geografia $amountGeografiaIncorrects');
    print('historia $amountHistoriaIncorrects');
    print('ciencias $amountCienciasIncorrects');
  }
}
