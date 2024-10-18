import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mongodb_api/models/models.dart';

class Service {
  static var api_key = const String.fromEnvironment('API_KEY');
  static var api_url = const String.fromEnvironment('API_URL');

  static final String apiUrl =
      'https://$api_key+$api_url';

  String getApi() {
    return apiUrl;
  }

  Future<List<Map<String, dynamic>>> getRequest() async {
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

    print(result);
    return result;
  }
}
