import 'package:minha_mesada/database/dao_ritgh.dart';
import 'package:minha_mesada/database/dao_wrong.dart';
import 'package:minha_mesada/database/database.dart';
import 'package:minha_mesada/models/models_user_resum.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _user = 'resumTable';
  // static const int _id = 0;
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
  static List<Map<String, dynamic>> id = [];
  static List<Map<String, dynamic>> table = [];
  DaoRight databaseRight = DaoRight();
  DaoWrong databaseWrong = DaoWrong();

  static const String tableUser = 'CREATE TABLE $_user('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
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
      await db.insert(_user, resumUser);
      print('Dados salvo com sucesso');
    } catch (e) {
      print('Erro ao salvar dados: $e');
    }
  }

  Future findAll() async {
    final db = await getConnection();
    table = await db.query(_user);

    print(table);
  }

  Future insertPoints(String value) async {
    final db = await getConnection();
    try {
      await db.rawInsert('INSERT INTO $_user($_totalPoints) VALUES($value)');

      print('Pontos inseridos com sucesso');
    } catch (erro) {
      print('Erro ao inserir pontos: $erro');
    }
  }

  Future insertUser(ModelsUserResum userRegister) async {
    final db = await getConnection();
    final Map<String, dynamic> user = toMap(userRegister);
    try {
      await db.insert(_user, user);
      print('Usuário inserido com sucesso');
    } catch (erro) {
      print('Erro ao inserir dados do usuário: $erro');
    }
  }

  Future insertPassword(String password) async {
    final db = await getConnection();
    try {
      await db.rawInsert('INSERT INTO $_user($_password) VALUES("password")');
      print('Senha inserida com sucesso');
    } catch (erro) {
      print('Erro ao inserir senha: $erro');
    }
  }

  Future findPoints() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> points = await db.query(_user);
    try {
      if (points[0]['totalPoints'] == null) {
        totalPoints = '0';
      } else {
        totalPoints = points[0]['totalPoints'];
      }
    } catch (erro) {
      print('Erro ao encontrar pontos: $erro');
    }

    print('totalPoints= $totalPoints');
  }

  Future findErrors() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> errors = await db.query(_user);
    try {
      if (errors[0]['totalError'] == null) {
        totalErrors = '0';
      } else {
        totalErrors = errors[0]['totalError'];
      }
    } catch (erro) {
      print('Erro ao encontrar erros: $erro');
    }

    print('totalErrors = $totalErrors');
  }

  Future findUserName() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_user);
    userName = user[0]['name'];
    print(userName);
  }

  Future findElementarySchoolAndSeries() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user =
        await db.query(_user, distinct: true, columns: [_elementarySchool]);
    print(user);
    //print('Escola primária: ${user[0]['elementarySchool']}, Grau: ${user[0]['grade']}' );
  }

  Future findAnswered() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> answered = await db.query(_user);

    try {
      answeredQuestions = answered[0]['totalOfQuestions'];
      findPoints();
      findErrors();
      databaseRight
          .findMatterAsRight(); // faz busca das meterias das questoes respodidas certas
      databaseWrong
          .findDispliceAsWrongs(); // faz busca das meterias das questoes respodidas
      // if (answered[0]['totalOfQuestions'] == null) {
      //   answeredQuestions = '0';
      // } else {

      // }
    } catch (erro) {
      print('Erro ao pegar quantidade de perguntas respondidas: $erro');
    }

    print('Total de respondidas = $answeredQuestions');
  }

  Future updatePoints(String lastValue, String currentValue) async {
    final Database db = await getConnection();
    try {
      await db.rawUpdate(
          'UPDATE $_user SET $_totalPoints = ? WHERE $_totalPoints = ?',
          [lastValue, currentValue]);
      List<Map<String, dynamic>> points = await db.query(_user);
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
          'UPDATE $_user SET $_totalError = ? WHERE $_totalError = ?',
          [lastValue, currentValue]);
      List<Map<String, dynamic>> errors = await db.query(_user);
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
          'UPDATE $_user SET $_totalOfQuestions = ? WHERE $_totalOfQuestions = ?',
          [lastValue, currentValue]);
      List<Map<String, dynamic>> answered = await db.query(_user);
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
      await db.delete(_user);
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }
}
