import 'dart:convert';

class ShowSubjects {
  static List<Map<String, dynamic>> mapListSubAndYear = [];

  showSubjectsAndSchoolyeaAll(
      String discipline, List<Map<String, dynamic>> listMap) {
    Map<String, dynamic> mapYearAndSubject = {};
    List<Map<String, dynamic>> result = [];

    mapListSubAndYear.clear();

    if (listMap.isNotEmpty) {
      for (var map in listMap) {
        if (map['displice'] == discipline) {
          mapYearAndSubject = {
            'schoolYear': map['schoolYear'],
            'subjects': map['subject'],
            // 'lenght':
          };
          result.add(mapYearAndSubject);
        }
      }

      final jsonList = result.map((el) => jsonEncode(el)).toList();
      final setList = jsonList.toSet().toList();
      final decodeList = setList.map((el) => jsonDecode(el)).toList();

      for (var listMap in decodeList) {
        mapListSubAndYear.add(listMap);
      }

      print('mapListSubAndYear $mapListSubAndYear');
    }
  }
}
