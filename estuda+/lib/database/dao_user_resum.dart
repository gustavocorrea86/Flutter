import 'dart:convert';
import 'package:estudamais/database/database.dart';
import 'package:estudamais/models/models_user_resum.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _user = 'tableUsers';

  static const String _idQuestions = 'idQuestion';
  static const String _idQuestionCorrect = 'idQuestionCorrect';
  static const String _idQuestionIncorrect = 'idQuestionIncorrect';

  String idQuest = '';
  String idQuestCorrect = '';
  //String idQuestIncorrect = '';
  static List<dynamic> listId = [];
  static List<dynamic> listIdCorrects = [];
  static List<dynamic> listIdIncorrects = [];
  String idInitial = '';
  String idInitialCorrects = '';
  String idInitialIncorrects = '';

  static List<Map<String, dynamic>> table = [];

  static const String tableUser = 'CREATE TABLE $_user('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_idQuestions TEXT,'
      '$_idQuestionCorrect TEXT,'
      '$_idQuestionIncorrect TEXT)';

  Map<String, dynamic> toMap(ModelsUserResum resumUser) {
    return {
      _idQuestions: resumUser.idQuestions,
      _idQuestionCorrect: resumUser.idQuestionCorrect,
      _idQuestionIncorrect: resumUser.idQuestionIncorrect,
    };
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
      //listId = listIdAux.toSet().toList();
      //print('listId $listId');
    } catch (erro) {
      print('Erro ao atualizar id das questões: $erro');
    }
    findAll();
  }

  Future updateIdQuestionsCorrect(List<dynamic> id) async {
    //listIdCorrects.clear();
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
    String idQuestIncorrect = '';
   
    final Database db = await getConnection();
    List<Map<String, dynamic>> user =
        await db.query(_user); //FAZ DA LIST DOS IDS ATUAIS
    idQuestIncorrect = user[0]['idQuestionIncorrect']; // ARMAZENA O RESULTADO
    print('idQuestIncorrect $idQuestIncorrect');
    final listIdJson = jsonEncode(id); // CONVERTE PARA JSON O ID A SER INSERIDO
    print('listIdJson $listIdJson');
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
    //listIdCorrects.clear();
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
    //listIdIncorrects.clear();
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_user);
    idInitialIncorrects = user[0]['idQuestionIncorrect'];
    var idList = jsonDecode(user[0]['idQuestionIncorrect']);
    if (idList == 0) {
      idList = '0';
    } else {
      listIdIncorrects = idList;
    }
    //print('listIdIncorrect $listIdIncorrects');
  }

//remove o id da questão incorretada listIdIncorrects, da -1 na quantidade respondida e -1 na quatidade de questões iconrretas
  Future removeIdQuestionsIncorrects(String id) async {
    //listIdIncorrects.clear();
    //findIdQuestionsIncorrect();
    List<dynamic> idsCurrent = [];
    final Database db = await getConnection();
    List<Map<String, dynamic>> user = await db.query(_user);

    if (listIdIncorrects.length == 1) {
      var idLast = user[0]['idQuestionIncorrect'];
      var newId = jsonEncode(0);
      await db.rawUpdate(
        // ATUALIZA O ID INSERIDO
        'UPDATE $_user SET $_idQuestionIncorrect = ? WHERE $_idQuestionIncorrect = ?',
        [newId, idLast],
      );
      print('passou aqui');

      listIdIncorrects.remove(id);
    } else {
      if (listIdIncorrects.contains(id)) {
        var idList = jsonDecode(user[0]['idQuestionIncorrect']);
        idsCurrent = idList;
        idsCurrent.remove(id);
        updateIdQuestionsIncorrect(idsCurrent);
        listIdIncorrects.remove(id);
        print(idsCurrent);
      }
    }
  }

  Future test(String id) async {
    if (listIdCorrects.contains(id)) {
      final Database db = await getConnection();

      List listIncorrect = [];
      List<Map<String, dynamic>> user = await db.query(_user);
      //var idListCorrect = jsonDecode(user[0]['idQuestionCorrect']);
      var idListIncorrect = jsonDecode(user[0]['idQuestionIncorrect']);
      listIncorrect = idListIncorrect;
      //listCorrect = idListCorrect;
      listIncorrect.remove(id);
      updateIdQuestionsIncorrect(listIncorrect);
    }
  }

  Future addIncorrectsInCorrects(String id) async {
    listIdCorrects.clear();
    //findIdQuestionsCorrect();
    List<dynamic> idsCurrent = [];
    //final Database db = await getConnection();
    //List<Map<String, dynamic>> user = await db.query(_user);
    if (listIdCorrects.isEmpty) {
      idsCurrent.add(id);
      updateIdQuestionsCorrect(idsCurrent);
    } else if (!listIdCorrects.contains(id)) {
      idsCurrent = DaoUserResum.listIdCorrects;
      idsCurrent.add(id);
      updateIdQuestionsCorrect(idsCurrent);
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
