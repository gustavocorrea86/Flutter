import 'package:mongodb_api/database/database.dart';
import 'package:mongodb_api/models/model_right.dart';
import 'package:sqflite/sqflite.dart';

class DaoRight {
  static const String _right = 'right';

  static const String _materia = 'materia';
  static const String _assunto = 'assunto';
  static const String _pergunta = 'pergunta';
  static const String _resposta = 'resposta';
  static const String _alternativaA = 'alternativaA';
  static const String _alternativaB = 'alternativaB';
  static const String _alternativaC = 'alternativaC';
  static const String _alternativaD = 'alternativaD';

  static List<String> assuntos = [];
  static List<String> materias = [];

  static List<String> questionsForSubject = [];
  static List<Map<String, dynamic>> listOfRightSubject = [];
  static List<Map<String, dynamic>> listQuestions = [];

  static const String tableRight = 'CREATE TABLE $_right('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_materia TEXT,'
      '$_assunto TEXT,'
      '$_pergunta TEXT,'
      '$_resposta TEXT,'
      '$_alternativaA TEXT,'
      '$_alternativaB TEXT,'
      '$_alternativaC TEXT,'
      '$_alternativaD TEXT)';

  Map<String, dynamic> toMap(ModelRight right) {
    return {
      _materia: right.materia,
      _assunto: right.assunto,
      _pergunta: right.pergunta,
      _resposta: right.resposta,
      _alternativaA: right.alternativaA,
      _alternativaB: right.alternativaB,
      _alternativaC: right.alternativaC,
      _alternativaD: right.alternativaD
    };
  }

  Future insertQuestionRight(ModelRight datas) async {
    final Database db = await getConnection();
    final Map<String, dynamic> question = toMap(datas);
    try {
      await db.insert(_right, question);
      print('Questão inserida na tableRight com sucesso');
    } catch (erro) {
      print('Erro ao inserir questão: $erro');
    }
  }

  Future findAllQuestionRight() async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> itsRight = await db.query(_right);
    print(itsRight);
  }

  Future deleteTableRight() async {
    final Database db = await getConnection();
    try {
      await db.delete(_right);
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }

  Future findForMatter(String materia) async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> questions =
        await db.query(_right, where: 'materia = ? ', whereArgs: [materia]);

    print(questions);
  }

  Future lenghtSubject() async {
    final Database db = await getConnection();
    questionsForSubject = [];
    List subjects = [];
    final List<Map<String, dynamic>> assuntos =
        await db.query(_right, distinct: true, columns: [_assunto]);

    for (var assunto in assuntos) {
      subjects.add(assunto[_assunto]);
    }
    for (var lengthAssunto in subjects) {
      final List<Map<String, dynamic>> questions = await db
          .query(_right, where: 'assunto = ? ', whereArgs: [lengthAssunto]);

      questionsForSubject.add(questions.length.toString());
    }

    print('questionsForSubject = $questionsForSubject');
  }

  Future findForSubject(String assunto) async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> questions =
        await db.query(_right, where: 'assunto = ? ', whereArgs: [assunto]);

    print(questions);
  }

  Future removeQuestions(String question) async {
    listQuestions.contains(question);
    print(listQuestions);
  }

  Future getQuestions(String assunto) async {
    final Database db = await getConnection();

    final List<Map<String, dynamic>> questions =
        await db.query(_right, where: 'assunto = ? ', whereArgs: [assunto]);
    for (var question in questions) {
      listQuestions.add(question);
    }
    print('listQuestions = $listQuestions');
    return listQuestions;
  }

  Future findForSubjectOfRight(String value) async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> questions =
        await db.query(_right, distinct: true, columns: [_assunto]);
    //await db.query(_right, where: 'assunto = ? ', whereArgs: [value]);

    listOfRightSubject.add(questions[0]);
    print('listOfRightSubject = $listOfRightSubject');
    return listOfRightSubject;
  }

  Future<List<String>> findSubjectAsRight() async {
    final Database db = await getConnection();
    assuntos = [];
    final List<Map<String, dynamic>> assunt =
        await db.query(_right, distinct: true, columns: [_assunto]);

    for (var element in assunt) {
      assuntos.add(element[_assunto]);
    }

    print('assuntos = $assuntos');

    return assuntos;
  }

  Future<List<String>> findMatterAsRight() async {
    final Database db = await getConnection();
    materias = [];
    final List<Map<String, dynamic>> materia =
        await db.query(_right, distinct: true, columns: [_materia]);

    for (var element in materia) {
      materias.add(element[_materia]);
    }
    print(materia);
    print(materias);
    return assuntos;
  }
}
