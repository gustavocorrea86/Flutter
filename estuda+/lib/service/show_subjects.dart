import 'dart:convert';

class ShowSubjects {
  static List<Map<String, dynamic>> mapListSubAndYear = [];

  Future<List<Map<String, dynamic>>> showSubjectsAndSchoolyeaAll(
      String discipline, List<Map<String, dynamic>> listMap) async {
    Map<String, dynamic> mapYearAndSubject = {};
    List<Map<String, dynamic>> result = [];

    mapListSubAndYear.clear();

    // for (var lenSub in listMap) {
    //   if (lenSub['displice'] == discipline) {
    //     lenghtSubjects.add(lenSub['subject']);
    //   }
    // }
    //print('lenghtSubjecs $lenghtSubjects');

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
      //print('result ${result}');
      // remove duplicates from the list and convert it to a Set to avoid duplicates.
      final jsonList = result.map((el) => jsonEncode(el)).toList();
      final setList = jsonList.toSet().toList();
      final decodeList = setList.map((el) => jsonDecode(el)).toList();

      for (var listMap in decodeList) {
        mapListSubAndYear.add(listMap);
      }

      print('mapListSubAndYear $mapListSubAndYear');
    }
    return mapListSubAndYear;
  }
}
