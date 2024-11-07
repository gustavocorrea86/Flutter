import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Service {
  static String api_key = dotenv.env['API_KEY']!;
  static String api_url = dotenv.env['API_URL']!; 

  String apiUrl = 'https://$api_key$api_url';

  static List currentQuestion = [];
  String getApi() {
    return apiUrl;
  }

  static List<Map<String, dynamic>> result = [];

  Future<List<Map<String, dynamic>>> getRequest() async {
    result = [];
    http.Response response = await http.get(Uri.parse(getApi()));

    var decodedResponse = utf8.decode(response.bodyBytes);

    try {
      if (response.statusCode == 200) {
        var list = await json.decode(decodedResponse);

        for (var listMap in list) {
          result.add(listMap);
        }
        print(api_key);
      }
    } catch (erro) {
      print('Falha na busca dos dados: $erro');
    }

    // print(result);
    return result;
  }
}
