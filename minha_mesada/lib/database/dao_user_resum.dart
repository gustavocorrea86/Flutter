import 'package:mongodb_api/database/database.dart';
import 'package:mongodb_api/models/models_user_resum.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _tableName = 'resumTable';

  static const String _name = 'name';
  static const String _lastName = 'lastName';
  static const String _age = 'age';
  static const String _elementarySchool = 'elementarySchool';
  static const String _grade = 'grade';

  static const String _password = 'password';
  static const String _monthPoints = 'monthPoints';
  static const String _totalPoints = 'totalPoints';
  static const String _totalOfQuestions = 'totalOfQuestions';
  static const String _totalError = 'totalError';
  static const String _monthError = 'monthError';

  static String totalPoints = '0';
  static String totalErrors = '0';
  static String userName = '';
  static String answeredQuestions = '0';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT,'
      '$_lastName TEXT,'
      '$_age TEXT,'
      '$_elementarySchool TEXT,'
      '$_grade TEXT,'
      '$_monthPoints TEXT,'
      '$_totalPoints TEXT,'
      '$_totalOfQuestions TEXT,'
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
      _totalPoints: totalPoints,
      _totalOfQuestions: resumUser.totalOfQuestions,
      _totalError: resumUser.totalError,
      _monthError: resumUser.monthErrors
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
      await db
          .rawInsert('INSERT INTO $_tableName($_totalPoints) VALUES($value)');

      print('Pontos inseridos com sucesso');
    } catch (erro) {
      print('Erro ao inserir pontos: $erro');
    }
  }

  Future insertUser(ModelsUserResum userRegister) async {
    final db = await getConnection();
    final Map<String, dynamic> user = toMap(userRegister);
    try {
      await db.insert(_tableName, user);
      print('Usuário inserido com sucesso');
    } catch (erro) {
      print('Erro ao inserir dados do usuário: $erro');
    }
  }

  Future insertPassword(String password) async {
    final db = await getConnection();
    try {
      await db
          .rawInsert('INSERT INTO $_tableName($_password) VALUES("password")');
      print('Senha inserida com sucesso');
    } catch (erro) {
      print('Erro ao inserir senha: $erro');
    }
  }

  Future findPoints() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> points = await db.query(_tableName);
    totalPoints = points[0]['totalPoints'];
    print('totalPoints= $totalPoints');
  }

  Future findErrors() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> errors = await db.query(_tableName);
    totalErrors = errors[0]['totalError'];
    print('totalErrors = $totalErrors');
  }

  Future findUserName() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_tableName);
    userName = user[0]['name'];
    print(userName);
  }

  Future findAnswereds() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> answered = await db.query(_tableName);
    answeredQuestions = answered[0]['totalOfQuestions'];
    print(
        'Total de respondidas = $answeredQuestions');
  }

  Future updatePoints(String lastValue, String currentValue) async {
    final Database db = await getConnection();
    try {
      await db.rawUpdate(
          'UPDATE $_tableName SET $_totalPoints = ? WHERE $_totalPoints = ?',
          [lastValue, currentValue]);
      List<Map<String, dynamic>> points = await db.query(_tableName);
      totalPoints = points[0]['totalPoints'];
      print('totalPoints no updatePoints = $totalPoints');
      print('Pontos atualização para $lastValue');
      print('Erros atualizados com sucesso');
    } catch (erro) {
      print('Erro ao atualizar pontos: $erro');
    }
  }

  Future updateErrors(String lastValue, String currentValue) async {
    final Database db = await getConnection();
    try {
      await db.rawUpdate(
          'UPDATE $_tableName SET $_totalError = ? WHERE $_totalError = ?',
          [lastValue, currentValue]);
      List<Map<String, dynamic>> errors = await db.query(_tableName);
      totalErrors = errors[0]['totalError'];
      print('totalErrors = $totalErrors');
      // print('Pontos atualização para $lastValue');
      print('Erros atualizados com sucesso');
    } catch (erro) {
      print('Erro ao atualizar Erros: $erro');
    }
  }

  Future updateAnswereds(String lastValue, String currentValue) async {
    final Database db = await getConnection();
    try {
      await db.rawUpdate(
          'UPDATE $_tableName SET $_totalOfQuestions = ? WHERE $_totalOfQuestions = ?',
          [lastValue, currentValue]);
          List<Map<String, dynamic>> answered = await db.query(_tableName);
          answeredQuestions = answered[0]['totalOfQuestions'];
      print('Número de respostas feitas com sucesso');
    } catch (erro) {
      print('Erro ao atualizar respostas feitas: $erro');
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
}
