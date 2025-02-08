import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class QuestionsIncorrects {
  final String _questoesAll = dotenv.env['questoes']!;
  static List<Map<String, dynamic>> resultQuestionsIncorrect = [];
  static List<String> listDisciplinesIncorrect = [];
  static List<String> listSubjectsIncorrect = [];
  static List<Map<String, dynamic>> mapListSubAndYearIncorrects = [];
  static List<String> listSchoolYearsIncorrects = [];
  static int subjectLength = 0;
  var logger = Logger();

// PEGA TODAS AS QUESTÕES RESPONDIDAS CORRETAMENTE, COLOCA EM UMA LIST CENTRAL PARA PODER SRVIR COMO BASE DE CONSULTA. É CHAMADO NO CARREGAMENTO DA HOME.
  Future<List<ModelQuestions>> getQuestionsIncorrects() async {
    List listIncorrects = [];
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
        logger.i('Questões incorretas recebidas com sucesso');
      }
    } catch (err) {
      logger.e('Erro ao buscar questões incorretas: $err');
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

// PEGA AS DISCIPLINAS QUE FORAM RESPONDIDAS CORRETAMENTE,PARA PODER RENDERIZAR NA accumulated_right
  getDisciplineOfQuestionsIncorrecs() {
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
      logger.e('Erro ao buscar disciplinas: $e');
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
}
