import 'package:minha_mesada/database/database.dart';
import 'package:minha_mesada/models/model_wrongs.dart';
import 'package:sqflite/sqflite.dart';

class DaoWrong {
  static const String _wrong = 'wrong';
  static const String _materia = 'materia';
  static const String _assunto = 'assunto';
  static const String _pergunta = 'pergunta';
  static const String _resposta = 'resposta';
  static const String _alternativaA = 'alternativaA';
  static const String _alternativaB = 'alternativaB';
  static const String _alternativaC = 'alternativaC';
  static const String _alternativaD = 'alternativaD';
  static List<Map<String, dynamic>> listOfWrongSubjects = [];
  static List<String> subjects = [];
  static List<String> lengthSubject = [];
  static List<String> displice = [];
  static List<Map<String, dynamic>> listQuestionsWrongs = [];

  static const String tableWrong = 'CREATE TABLE $_wrong('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_materia TEXT,'
      '$_assunto TEXT,'
      '$_pergunta TEXT,'
      '$_resposta TEXT,'
      '$_alternativaA TEXT,'
      '$_alternativaB TEXT,'
      '$_alternativaC TEXT,'
      '$_alternativaD TEXT)';

  Map<String, dynamic> toMap(ModelWrong wrong) {
    return {
      _materia: wrong.materia,
      _assunto: wrong.assunto,
      _pergunta: wrong.pergunta,
      _resposta: wrong.resposta,
      _alternativaA: wrong.alternativaA,
      _alternativaB: wrong.alternativaB,
      _alternativaC: wrong.alternativaC,
      _alternativaD: wrong.alternativaD
    };
  }

  Future insertQuestionWrong(ModelWrong datas) async {
    final Database db = await getConnection();
    final Map<String, dynamic> question = toMap(datas);
    try {
      await db.insert(_wrong, question);
      print('Questão inserida na tableWrong com sucesso');
    } catch (erro) {
      print('Erro ao inserir questão: $erro');
    }
  }

  Future findAllQuestionWrong() async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> itsRight = await db.query(_wrong);
    print(itsRight);
  }

  Future<List<String>> findDispliceAsWrongs() async {
    final Database db = await getConnection();
    displice.clear();
    final List<Map<String, dynamic>> materia =
        await db.query(_wrong, distinct: true, columns: [_materia]);

    for (var element in materia) {
      displice.add(element[_materia]);
    }
    //print(materia);
    print(displice);
    return displice;
  }

  Future<List> findForMatter_subjectAndLength(String matter) async {
    final Database db = await getConnection();

    listOfWrongSubjects.clear();
    subjects.clear();
    lengthSubject.clear();
    Map<String, dynamic> listSub;
    List<Map<String, dynamic>> subjectForMatter = await db.query(_wrong,
        where: 'materia = ?',
        whereArgs: [matter],
        distinct: true,
        columns: [_assunto]);

    for (var sub in subjectForMatter) {
      subjects.add(sub[_assunto]);
    }

    for (var lengthAssunto in subjects) {
      final List<Map<String, dynamic>> questions = await db
          .query(_wrong, where: 'assunto = ? ', whereArgs: [lengthAssunto]);

      lengthSubject.add(questions.length.toString());
    }

    for (var sub in subjects) {
      listSub = {
        'assunto': sub,
        'tamanho': lengthSubject[subjects.indexOf(sub)]
      };
      listOfWrongSubjects.add(listSub);
    }
    print(listOfWrongSubjects);
    //print('$subjects, $lengthSubject');
    return listOfWrongSubjects;
  }

  Future<List<Map<String , dynamic>>> findMatterAsWrong() async {
    final Database db = await getConnection();
    //List<String>? materias = [];
    //materias.clear();
    final List<Map<String, dynamic>> materia =
        await db.query(_wrong, distinct: true, columns: [_materia]);

    // for (var element in materia) {
    //   materias.add(element[_materia]);
    // }
    
    //print(materia);
   // print('materias = $materias');
    return materia;
  }

  Future removeQuestionsDetails(String question) async {
    for (var obj in listQuestionsWrongs) {
      if (obj['assunto'] == question) {
        listQuestionsWrongs.removeWhere((item) => item['assunto'] == question);
        break;
      }
    }
    print('listQuestions = $listQuestionsWrongs');
  }

  Future getQuestions(String assunto) async {
    final Database db = await getConnection();

    final List<Map<String, dynamic>> questions =
        await db.query(_wrong, where: 'assunto = ? ', whereArgs: [assunto]);
    for (var question in questions) {
      listQuestionsWrongs.add(question);
    }
    print('listQuestions = $listQuestionsWrongs');
    return listQuestionsWrongs;
  }

  Future deleteTableWrong() async {
    final Database db = await getConnection();
    try {
      await db.delete(_wrong);
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }
}
