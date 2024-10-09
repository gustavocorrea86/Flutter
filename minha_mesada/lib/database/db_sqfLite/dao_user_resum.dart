import 'package:mongodb_api/database/db_sqfLite/database.dart';
import 'package:mongodb_api/models/models_user_resum.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _tableName = 'resum';
  static const String _name = 'name';
  static const String _age = 'age';
  static const String _elementarySchool = 'elementarySchool';
  static const String _serie = 'serie';
  static const String _monthPoints = 'monthPoints';
  static const String _totalPoints = 'totalPoints';
  static const String _totalError = 'totalError';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT,'
      '$_age TEXT'
      '$_elementarySchool'
      '$_serie'
      '$_monthPoints'
      '$_totalPoints'
      '$_totalError)';

  Map<String, dynamic> toMap(ModelsUserResum resumUser) {
    return {
      'name': resumUser.name,
      'age': resumUser.age,
      'elementarySchool': resumUser.elementarySchool,
      'grade': resumUser.grade,
      'monthPoints': resumUser.monthPoints,
      'totalPoints': resumUser.totalPoints,
      'hits': resumUser.hits,
      'errors': resumUser.errors,
    };
  }

  Future save(ModelsUserResum datas) async {
    final db = await getConnection();
    final Map<String, dynamic> resumUser = toMap(datas);
    try {
      await db.insert(_tableName, resumUser);
      print('Dados salvocom sucesso');
    } catch (e) {
      print('Erro ao salvar dados: $e');
    }
  }
}
