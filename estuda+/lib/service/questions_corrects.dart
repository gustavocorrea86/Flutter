import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:http/http.dart' as http;

class QuestionsCorrects {
  final String _questoesAll = dotenv.env['questoes']!;
  static List<Map<String, dynamic>> resultQuestionsCorrect = [];
  static List<String> listDisciplinesCorrect = [];
  static List<String> listSubjectsCorrect = [];
  static int subjectLength = 0;

  Future<List<ModelQuestions>> getQuestionsCorrects() async {
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
        print('Questões corretas recebidas com sucesso');
        for (var q in listCorrects) {
          print('Questões corretas => $q');
          print('tamanho da list ${listCorrects.length}');
        }
      }
    } catch (err) {
      print('Erro ao buscar questões: $err');
    }

    return List<ModelQuestions>.from(
      listCorrects.map(
        (element) {
          Uint8List bytesImage =
              Uint8List.fromList(element['image']['data'].cast<int>());
          element['image'] = bytesImage;
          resultQuestionsCorrect.add(element);
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  Future<List<String>> getDisciplineOfQuestionsCorrects() async {
    if (resultQuestionsCorrect.isNotEmpty) {
      for (var disciplines in resultQuestionsCorrect) {
        listDisciplinesCorrect.add(disciplines['displice']);
      }
    }
    return listDisciplinesCorrect.toSet().toList();
  }

  Future<List<String>> getSubjectsOfQuestionsCorrects(String discipline) async {
    List<String> list = [];
    try {
      if (resultQuestionsCorrect.isNotEmpty) {
        for (var subjects in resultQuestionsCorrect) {
          if (subjects['displice'] == discipline) {
            list.add(subjects['subject']);
          }
        }
        listSubjectsCorrect = list.toSet().toList();
        subjectLength = listSubjectsCorrect.length;
        print('subjects $listSubjectsCorrect');
      } else {}
    } on Exception catch (e) {
      print('Erro ao buscar assuntos: $e');
    }
    return listSubjectsCorrect;
  }
}
