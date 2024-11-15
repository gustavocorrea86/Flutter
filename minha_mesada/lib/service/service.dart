import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Service {
  static String apikey = dotenv.env['API_KEY']!;
  static String apiurl = dotenv.env['API_URL']!;

  String apiUrl = 'https://$apikey$apiurl';

  static List currentQuestion = [];
  String getApi() {
    return apiUrl;
  }

  static List<Map<String, dynamic>> result = [];

  Future<List<Map<String, dynamic>>> getRequest() async {
    result.clear();
    http.Response response = await http.get(Uri.parse(getApi()));

    var decodedResponse = utf8.decode(response.bodyBytes);

    try {
      if (response.statusCode == 200) {
        var list = await json.decode(decodedResponse);

        for (var listMap in list) {
          result.add(listMap);
        }
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    }

    print(result.length);
    return result;
  }
}
