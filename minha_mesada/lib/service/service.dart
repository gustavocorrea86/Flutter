import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estudamais/models/model_questions.dart';

//import 'package:dio/dio.dart';
final dio = Dio();

class Service {
  // static final String _apikey = dotenv.env['API_KEY']!;
  // static final String _apiurl = dotenv.env['API_URL']!;
  // static final String _localhost = dotenv.env['localhost']!;

  // String apiUrl = 'https://$_apikey$_apiurl';
  String _questoesUrl = dotenv.env['questoes']!;

  static List<Map<String, dynamic>> result = [];
  static List<String> listSubjectBySerie = [];
  static List<String> listSeries = [];
  static String serie = '';

  Future<List<ModelQuestions>> getQuestions() async {
    http.Response response =
        await http.get(Uri.parse('http://192.168.15.9:8080/questoes'));

    var decodedResponse = utf8.decode(response.bodyBytes);
    var list = await json.decode(decodedResponse);

    return List<ModelQuestions>.from(
      list.map(
        (element) {
          result.add(element);
          return ModelQuestions.toMap(element);
        },
      ),
    );
  }

  // Future<List<String>> getDisplice() async {
  //   http.Response response = await http.get(Uri.parse(apiUrl));
  //   var decodedResponse = utf8.decode(response.bodyBytes);

  //   List<String> listDisplice = [];
  //   try {
  //     if (response.statusCode == 200) {
  //       var list = await json.decode(decodedResponse);

  //       for (Map<String, dynamic> listMap in list) {
  //         listDisplice.add(listMap['materia']);
  //       }
  //     }
  //   } catch (erro) {
  //     print('Falha na busca dos dados: $erro');
  //   }
  //   print(listDisplice.toSet().toList());
  //   return listDisplice.toSet().toList();
  // }

  // Future<List<String>> getSubjects() async {
  //   http.Response response =
  //       await http.get(Uri.parse(_questoesUrl));
  //   var decodedResponse = utf8.decode(response.bodyBytes);
  //   List<String> listSubjects = [];
  //   List<String> listQuery = [];
  //   try {
  //     if (response.statusCode == 200) {
  //       var list = await json.decode(decodedResponse);

  //       for (Map<String, dynamic> listMap in list) {
  //         listQuery.add(listMap['serie']);
  //       }
  //       listSubjects = listQuery.toSet().toList();
  //     }
  //   } catch (erro) {
  //     print('Falha na busca dos dados: $erro');
  //   }

  //   print(listSubjects);
  //   return listSubjects;
  // }

  // Future<List<String>> getSeries() async {
  //   http.Response response =
  //       await http.get(Uri.parse('https://$_apikey$_apiurl'));
  //   var decodedResponse = utf8.decode(response.bodyBytes);

  //   List<String> listQuery = [];
  //   try {
  //     if (response.statusCode == 200) {
  //       var list = await json.decode(decodedResponse);

  //       for (Map<String, dynamic> listMap in list) {
  //         listQuery.add(listMap['serie']);
  //       }
  //       listSeries = listQuery.toSet().toList()..sort();
  //     }
  //   } catch (erro) {
  //     print('Falha na busca dos dados: $erro');
  //   }

  //   print(listSeries);
  //   return listSeries;
  // }

  // Future<List<String>> findSubjectsBySerie() async {
  //   http.Response response =
  //       await http.get(Uri.parse('https://$_apikey$_apiurl'));
  //   var decodedResponse = utf8.decode(response.bodyBytes);
  //   listSubjectBySerie.clear();
  //   List<String> listQuery = [];
  //   try {
  //     if (response.statusCode == 200) {
  //       var list = await json.decode(decodedResponse);

  //       for (var listMap in list) {
  //         if (listMap['serie'] == serie) {
  //           listQuery.add(listMap['assunto']);
  //         }
  //       }
  //       listSubjectBySerie = listQuery.toSet().toList();
  //     }
  //   } catch (erro) {
  //     print('Falha na busca dos dados: $erro');
  //   }

  //   //print(listQuery);
  //   print(listSubjectBySerie);
  //   return listSubjectBySerie;
  // }

  Future<List<String>> findSubjects(String subject) async {
    http.Response response =
        await http.get(Uri.parse('http://192.168.15.9:8080/matematica/1ano'));
    var decodedResponse = utf8.decode(response.bodyBytes);
    listSubjectBySerie.clear();
    List<String> listQuery = [];

    try {
      if (response.statusCode == 200) {
        var list = await json.decode(decodedResponse);
        print(list);
        for (var listMap in list) {
          if (listMap['subject'] == subject) {
            //listSubjectBySerie.add(listMap['assunto']);
            listQuery.add(listMap);
          }
        }
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    }

    //print(listQuery);
    print(listQuery);
    return listQuery;
  }

  Future<List<String>> findSubjectsByYear(String displice, String year) async {
    http.Response response =
        await http.get(Uri.parse('http://192.168.15.9:8080/$displice/$year'));
    List<String> listSubjectBySerie = [];
    try {
      if (response.statusCode == 200) {
        var list = await json.decode(response.body);
        //print(list);
        for (var listMap in list) {
          listSubjectBySerie.add(listMap['subject']);
        }
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    }
    //print(listQuery);
    print(listSubjectBySerie.toSet().toList());
    return listSubjectBySerie.toSet().toList();
  }
}
