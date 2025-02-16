import 'dart:convert';
import 'package:estudamais/database/database.dart';
import 'package:estudamais/models/models_user_resum.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _user = 'tableUsers';

  static const String _totalPoints = 'totalPoints';
  static const String _totalOfQuestions = 'totalOfQuestions';
  static const String _totalError = 'totalError';
  static const String _idQuestions = 'idQuestion';

  static const String _idQuestionCorrect = 'idQuestionCorrect';
  static const String _idQuestionIncorrect = 'idQuestionIncorrect';
  static String totalPoints = '0';
  static String totalErrors = '0';
  static String idQuest = '';
  static String idQuestCorrect = '';
  static String idQuestIncorrect = '';
  static List<dynamic> listId = [];
  static List<dynamic> listIdCorrects = [];
  static List<dynamic> listIdIncorrects = [];
  String idInitial = '';
  String idInitialCorrects = '';
  String idInitialIncorrects = '';
  static String userName = '';
  static String answeredQuestions = '0';
  static List<Map<String, dynamic>> table = [];

  static const String tableUser = 'CREATE TABLE $_user('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_totalPoints TEXT,'
      '$_totalOfQuestions TEXT,'
      '$_totalError TEXT,'
      '$_idQuestions TEXT,'
      '$_idQuestionCorrect TEXT,'
      '$_idQuestionIncorrect TEXT)';

  Map<String, dynamic> toMap(ModelsUserResum resumUser) {
    return {
      _totalPoints: totalPoints,
      _totalOfQuestions: resumUser.totalOfQuestions,
      _totalError: resumUser.totalError,
      _idQuestions: resumUser.idQuestions,
      _idQuestionCorrect: resumUser.idQuestionCorrect,
      _idQuestionIncorrect: resumUser.idQuestionIncorrect,
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

  Future updateIdQuestions(List<dynamic> id) async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user =
        await db.query(_user); //FAZ DA LIST DOS IDS ATUAIS
    idQuest = user[0]['idQuestion']; // ARMAZENA O RESULTADO
    final listIdJson = jsonEncode(id); // CONVERTE PARA JSON O ID A SER INSERIDO
    try {
      await db.rawUpdate(
        // ATUALIZA O ID INSERIDO
        'UPDATE $_user SET $_idQuestions = ? WHERE $_idQuestions = ?',
        [listIdJson, idQuest],
      );
      // FAZ A BUSCA NOVAMENT DE TODOS OS IDS ATUAIS
      List<Map<String, dynamic>> feedback = await db.query(_user);
      // CONVERTE O JSON PARA LISTA DE IDS ATUALIZADO
      var idList = jsonDecode(feedback[0]['idQuestion']);
      listId = idList;
      //print('listId $listId');
    } catch (erro) {
      print('Erro ao atualizar id das questões: $erro');
    }
    findAll();
  }

  Future updateIdQuestionsCorrect(List<dynamic> id) async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user =
        await db.query(_user); //FAZ DA LIST DOS IDS ATUAIS
    idQuestCorrect = user[0]['idQuestionCorrect']; // ARMAZENA O RESULTADO
    final listIdJson = jsonEncode(id); // CONVERTE PARA JSON O ID A SER INSERIDO
    try {
      await db.rawUpdate(
        // ATUALIZA O ID INSERIDO
        'UPDATE $_user SET $_idQuestionCorrect = ? WHERE $_idQuestionCorrect = ?',
        [listIdJson, idQuestCorrect],
      );
      // FAZ A BUSCA NOVAMENT DE TODOS OS IDS ATUAIS
      List<Map<String, dynamic>> feedback = await db.query(_user);
      // CONVERTE O JSON PARA LISTA DE IDS ATUALIZADO
      var idList = jsonDecode(feedback[0]['idQuestionCorrect']);
      listIdCorrects = idList;
      //print('listIdCorrect $listIdCorrects');
    } catch (erro) {
      print('Erro ao atualizar id das questões corretas: $erro');
    }
    findAll();
  }

  Future updateIdQuestionsIncorrect(List<dynamic> id) async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user =
        await db.query(_user); //FAZ DA LIST DOS IDS ATUAIS
    idQuestIncorrect = user[0]['idQuestionIncorrect']; // ARMAZENA O RESULTADO
    final listIdJson = jsonEncode(id); // CONVERTE PARA JSON O ID A SER INSERIDO
    try {
      await db.rawUpdate(
        // ATUALIZA O ID INSERIDO
        'UPDATE $_user SET $_idQuestionIncorrect = ? WHERE $_idQuestionIncorrect = ?',
        [listIdJson, idQuestIncorrect],
      );
      // FAZ A BUSCA NOVAMENT DE TODOS OS IDS ATUAIS
      List<Map<String, dynamic>> feedback = await db.query(_user);
      // CONVERTE O JSON PARA LISTA DE IDS ATUALIZADO
      var idList = jsonDecode(feedback[0]['idQuestionIncorrect']);
      listIdIncorrects = idList;
      print('listIdIncorrect $listIdIncorrects');
    } catch (erro) {
      print('Erro ao atualizar id das questões incorretas: $erro');
    }
    findAll();
  }

  //FAZ A BUSCA DOS IDS PARA ATUALIZAR
  Future findIdQuestionsCorrect() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_user);
    idInitialCorrects = user[0]['idQuestionCorrect'];
    var idList = jsonDecode(user[0]['idQuestionCorrect']);
    if (idList == 0) {
      idList = '0';
    } else {
      listIdCorrects = idList;
    }
    print('listIdCorrects $listIdCorrects');
  }

  Future findIdQuestions() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_user);
    idInitial = user[0]['idQuestion'];
    var idList = jsonDecode(user[0]['idQuestion']);
    if (idList == 0) {
      idList = '0';
    } else {
      listId = idList;
    }
    print('listId $listId');
  }

  Future findIdQuestionsIncorrect() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_user);
    idInitialIncorrects = user[0]['idQuestionIncorrect'];
    var idList = jsonDecode(user[0]['idQuestionIncorrect']);
    if (idList == 0) {
      idList = '0';
    } else {
      listIdIncorrects = idList;
    }
    print('listIdIncorrect $listIdIncorrects');
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

  Future findAnswered() async {
    final Database db = await getConnection();
    List<Map<String, dynamic>> answered = await db.query(_user);

    try {
      answeredQuestions = answered[0]['totalOfQuestions'];
      findPoints();
      findErrors();
      findIdQuestions();
      findIdQuestionsCorrect();
      findIdQuestionsIncorrect();
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

  // Future updateIdQuestion(String lastValue, String currentValue) async {
  //   final Database db = await getConnection();
  //   try {
  //     await db.rawUpdate(
  //         'UPDATE $_user SET $_idQuestions = ? WHERE $_idQuestions = ?',
  //         [lastValue, currentValue]);
  //     List<Map<String, dynamic>> answered = await db.query(_user);
  //     answeredQuestions = answered[0]['totalOfQuestions'];
  //     print('Número de respostas feitas com sucesso');
  //   } catch (erro) {
  //     print('Erro ao atualizar respostas feitas: $erro');
  //   }
  // }

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
