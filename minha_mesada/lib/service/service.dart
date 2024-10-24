import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mongodb_api/env/env.dart';


class Service {
  static String api_key = Env.apiKey;
  static String api_url = const String.fromEnvironment('API_URL',
      defaultValue: 'URL não encontrada');
      

  static const String apiUrl =
      'https://670cf70d7e5a228ec1d2214f.mockapi.io/api/v1/questoes';

// https://670cf70d7e5a228ec1d2214f.mockapi.io/api/v1/questoes
  String getApi() {
    return apiUrl;
  }

  Future<List<Map<String, dynamic>>> getRequest() async {
    // print(api_key);
    // print(api_url);
    http.Response response = await http.get(Uri.parse(getApi()));

    var decodedResponse = utf8.decode(response.bodyBytes);
    List<Map<String, dynamic>> result = [];

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

    // print(result);
    return result;
  }
}
