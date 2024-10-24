import 'package:mongodb_api/database/database.dart';
import 'package:mongodb_api/models/models.dart';
import 'package:mongodb_api/models/models_user_resum.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _tableName = 'resumTable';

  static const String _name = 'name';
  static const String _lastName = 'lastName';
  static const String _age = 'age';
  static const String _elementarySchool = 'elementarySchool';
  static const String _grade = 'grade';
  static const String _monthPoints = 'monthPoints';
  static const String _totalPoints = 'totalPoints';
  static const String _totalHits = 'totalHits';
  static const String _monthHits = 'monthHits';
  static const String _totalError = 'totalError';
  static const String _monthError = 'monthError';

  static String totalPoints = '0';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT,'
      '$_lastName TEXT,'
      '$_age TEXT,'
      '$_elementarySchool TEXT,'
      '$_grade TEXT,'
      '$_monthPoints TEXT,'
      '$_totalPoints TEXT,'
      '$_totalHits TEXT,'
      '$_monthHits TEXT,'
      '$_totalError TEXT,'
      '$_monthError TEXT)';

  Map<String, dynamic> toMap(ModelsUserResum resumUser) {
    return {
      _name: resumUser.name,
      _lastName: resumUser.lastName,
      _age: resumUser.age,
      _elementarySchool: resumUser.elementarySchool,
      _grade: resumUser.grade,
      _monthPoints: resumUser.monthPoints,
      _totalPoints: resumUser.totalPoints,
      _totalHits: resumUser.totalHits,
      _monthHits: resumUser.monthHits,
      _totalError: resumUser.totalErrors,
      _monthError: resumUser.monthErrors,
    };
  }

  Future save(ModelsUserResum datas) async {
    final db = await getConnection();
    final Map<String, dynamic> resumUser = toMap(datas);
    try {
      await db.insert(_tableName, resumUser);
      print('Dados salvo com sucesso');
    } catch (e) {
      print('Erro ao salvar dados: $e');
    }
  }

  Future findAll() async {
    final db = await getConnection();
    final List<Map<String, dynamic>> table = await db.query(_tableName);
    print(table);
  }

  Future insertPoints(String value) async {
    final db = await getConnection();
    try {
      int points = await db
          .rawInsert('INSERT INTO $_tableName($_totalPoints) VALUES($value)');
      print('Dados inseridos com sucesso');
      if (points == 1) {
        points = 0;
      }
      print('Pontos inseridos = $points');
    } catch (erro) {
      print('Erro ao inserir pontos: $erro');
    }
  }

  Future findPoints() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> points = await db.query(_tableName);

    totalPoints = points[0]['totalPoints'];
    print('totalPoints = $totalPoints');
    
  }

  Future updatePoints(String lastValue, String currentValue) async {
    final Database db = await getConnection();
    try {
      await db.rawUpdate(
          'UPDATE $_tableName SET $_totalPoints = ? WHERE $_totalPoints = ?',
          [lastValue, currentValue]);
      print('Pontos atualização para $lastValue');
      print('Dados atualizados com sucesso');
    } catch (erro) {
      print('Erro ao atualizar pontos: $erro');
    }
  }

  Future close() async {
    final db = await getConnection();
    try {
      await db.close();
      print('Banco de dados fechado com sucesso');
    } catch (e) {
      print('Erro ao fechar o banco de dados: $e');
    }
  }

  Future delete() async {
    final db = await getConnection();
    try {
      await db.delete(_tableName);
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }

  Future deleteDatabse() async {
    final db = await getConnection();
    try {
      db.database;
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }
}
