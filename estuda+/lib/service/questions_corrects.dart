import 'dart:convert';
import 'dart:typed_data';
import 'package:estudamais/models/model_questions.dart';
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
  static Set<String> subjectsOfQuestionsCorrects = {};
  //static List<Map<String, dynamic>> questionsCorrects = [];
  static List<ModelQuestions> resultQuestions = [];
  static int amountPortuguesCorrects = 0;
  static int amountMatematicaCorrects = 0;
  static int amountGeografiaCorrects = 0;
  static int amountHistoriaCorrects = 0;
  static int amountCienciasCorrects = 0;

// PEGA TODAS AS QUESTÕES RESPONDIDAS CORRETAMENTE pelo id da questão, COLOCA EM UMA LIST CENTRAL PARA PODER SRVIR COMO BASE DE CONSULTA. É CHAMADO NO CARREGAMENTO DA HOME.
  Future getQuestionsCorrects() async {
    List listCorrects = [];
    resultQuestionsCorrect.clear();
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
        for (var element in listCorrects) {
          Uint8List bytesImage =
              Uint8List.fromList(element['image']['data'].cast<int>());
          element['image'] = bytesImage;
          print(element);
          resultQuestionsCorrect.add(element);
        }

        print('Questões corretas recebidas com sucesso');
        //print('resultQuestionsCorrect $resultQuestionsCorrect');
      }
    } catch (err) {
      print('Erro ao buscar questões: $err');
    }
  }

// PEGA AS DISCIPLINAS QUE FORAM RESPONDIDAS CORRETAMENTE ao clicar em resumo ,PARA PODER RENDERIZAR NA accumulated_right no Widget animated_button_progress.dart
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

  //MÉTODO QUE SERVE COMO BASE DE CONSULTA DE QUESTÕES POR ASSUNTO, ATRAVÉS DA LIST subjectsOfQuestionsCorrects
  void getQuestionsCorrectsForSubjects(String subject) {
    subjectsOfQuestionsCorrects.add(subject);
    try {
      for (var questions in resultQuestionsCorrect) {
        for (var sub in subjectsOfQuestionsCorrects) {
          if (questions['subject'] == sub) {
            resultQuestions.add(ModelQuestions.toMap(questions));
          }
        }
      }
    } on Exception catch (e) {
      print('Erro ao buscar questões por assunto: $e');
    }
  }

  counterDisciplineCorrects() {
    List<String> portugues = [];
    List<String> matematica = [];
    List<String> geografia = [];
    List<String> historia = [];
    List<String> ciencias = [];
    print('matematica1 $matematica');

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
        case 'Ciências da Natureza':
          ciencias.add(dis['displice']);
          amountCienciasCorrects = ciencias.length;
      }
    }
    print('matematica2 $matematica');
    print('portugues $amountPortuguesCorrects');
    print('matematica $amountMatematicaCorrects');
    print('geografia $amountGeografiaCorrects');
    print('historia $amountHistoriaCorrects');
    print('ciencias $amountCienciasCorrects');
  }
}
