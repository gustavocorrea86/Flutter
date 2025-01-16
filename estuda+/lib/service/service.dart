import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/models/model_questions.dart';

//import 'package:dio/dio.dart';
final dio = Dio();

class Service {
  // static final String _apikey = dotenv.env['API_KEY']!;
  // static final String _apiurl = dotenv.env['API_URL']!;
  // static final String _localhost = dotenv.env['localhost']!;

  // String apiUrl = 'https://$_apikey$_apiurl';
  final String _questoesAll = dotenv.env['questoes']!;

  static List<Map<String, dynamic>> result = [];
  static List<String> listSubjectBySerie = [];
  static List<String> listSeries = [];

  Future<List<ModelQuestions>> getQuestions() async {
    List list = [];

    http.Response response =
        await http.get(Uri.parse('http://$_questoesAll/questoes'));
    try {
      if (response.statusCode == 200) {
        list = await json.decode(response.body);
      }
    } catch (err) {
      print('Erro ao buscar questões: $err');
    }

    return List<ModelQuestions>.from(
      list.map(
        (element) {
          print('element do getQuestions: $element');
          Uint8List bytesImage =
              Uint8List.fromList(element['image']['data'].cast<int>());
          element['image'] = bytesImage;
          result.add(element);

          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  Future<List<ModelQuestions>> findQuestionsBySchoolYear(
      String displice, String year) async {
    http.Response response =
        await http.get(Uri.parse('http://$_questoesAll/$displice/$year'));
    List list = [];

    try {
      if (response.statusCode == 200) {
        list = await json.decode(response.body);
      }
    } catch (err) {
      print('Erro ao buscar questões: ${response.reasonPhrase}');
    }

    return List<ModelQuestions>.from(
      list.map(
        (element) {
          result.add(element);
          Uint8List bytesImage =
              Uint8List.fromList(element['image']['data'].cast<int>());
          element['image'] = bytesImage;
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  Future<List<String>> findSubjectsBySchoolYear(
      String displice, String year) async {
    print('displice: $displice year: $year');

    List<String> listSubjectBySchoolYear = [];
    result.clear();
    try {
      http.Response response =
          await http.get(Uri.parse('http://$_questoesAll/$displice/$year'));
      if (response.statusCode == 200) {
        var list = await json.decode(response.body);
        print('list $list');
        for (var listMap in list) {
          result.add(listMap);
          listSubjectBySchoolYear.add(listMap['subject']);
        }
        //print(result);
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    }
    print(listSubjectBySchoolYear.toSet().toList());
    return listSubjectBySchoolYear.toSet().toList();
  }

  Future<List<ModelQuestions>> findQuestionsBySubjects(String subject) async {
    List list = [];
    try {
      if (Service.result.isNotEmpty) {
        list =
            result.where((element) => element['subject'] == subject).toList();
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
          result.add(element);
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  Future<List<ModelQuestions>> findQuestionsAllBySubjects(
      String schoolYear, String displice, String subject) async {
    print('schoolYear $schoolYear, displice $displice, subject $subject');
    List list = [];
    // List listResult = [];
    http.Response response =
        await http.get(Uri.parse('http://$_questoesAll/questoes'));
    try {
      if (response.statusCode == 200) {
        list = await json.decode(response.body);
        if (list.isNotEmpty) {
          list = list
              .where((element) =>
                  element['schoolYear'] == schoolYear &&
                  element['displice'] == displice &&
                  element['subject'] == subject)
              .toList();
        }
        print('list $list');
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
          print('elementooooo: $element');
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }
}
