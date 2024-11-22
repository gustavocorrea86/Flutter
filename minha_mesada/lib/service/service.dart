import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:minha_mesada/models/model_questions.dart';
//import 'package:dio/dio.dart';

class Service {
  static String _apikey = dotenv.env['API_KEY']!;
  static String _apiurl = dotenv.env['API_URL']!;

  String apiUrl = 'https://$_apikey$_apiurl';

  static List<Map<String, dynamic>> result = [];
  static List<String> listSubjects = [];

  Future<List<ModelQuestions>> getQuestions() async {
    http.Response response = await http.get(Uri.parse(apiUrl));

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

  Future<List<String>> getDisplice() async {
    http.Response response = await http.get(Uri.parse(apiUrl));
    var decodedResponse = utf8.decode(response.bodyBytes);

    List<String> listDisplice = [];
    try {
      if (response.statusCode == 200) {
        var list = await json.decode(decodedResponse);

        for (Map<String, dynamic> listMap in list) {
          listDisplice.add(listMap['materia']);
        }
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    }
    print(listDisplice.toSet().toList());
    return listDisplice.toSet().toList();
  }

  static Future<List<String>> getSubjects(String query) async {
    http.Response response =
        await http.get(Uri.parse('https://$_apikey$_apiurl'));
    var decodedResponse = utf8.decode(response.bodyBytes);
    List<String> listQuery = [];
    try {
      if (response.statusCode == 200) {
        var list = await json.decode(decodedResponse);

        for (Map<String, dynamic> listMap in list) {
          listQuery.add(listMap[query]);
        }
        listSubjects = listQuery.toSet().toList();
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    } 

    print(listSubjects);
    return listSubjects.toSet().toList();
  }
}
