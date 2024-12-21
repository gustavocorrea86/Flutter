import 'package:estudamais/database/database.dart';
import 'package:estudamais/models/model_questions.dart';

import 'package:sqflite/sqflite.dart';

class DaoWrong {
  static const String _wrong = 'wrong';
  static const String _id = 'id';
  static const String _elementarySchool = 'elementarySchool';
  static const String _series = 'series';
  static const String _displice = 'displice';
  static const String _subject = 'subject';
  static const String _question = 'question';
  static const String _response = 'response';
  static const String _alternativeA = 'alternativeA';
  static const String _alternativeB = 'alternativeB';
  static const String _alternativeC = 'alternativeC';
  static const String _alternativeD = 'alternativeD';
  static List<Map<String, dynamic>> listOfWrongSubjects = [];
  static List<String> subjects = [];
  static List<String> lengthSubject = [];
  static List<String> displice = [];
  static List<Map<String, dynamic>> listQuestionsWrongs = [];

  static const String tableWrong = 'CREATE TABLE $_wrong('
      '$_id TEXT,'
      '$_elementarySchool TEXT,'
      '$_series TEXT,'
      '$_displice TEXT,'
      '$_subject TEXT,'
      '$_question TEXT,'
      '$_response TEXT,'
      '$_alternativeA TEXT,'
      '$_alternativeB TEXT,'
      '$_alternativeC TEXT,'
      '$_alternativeD TEXT)';

  Map<String, dynamic> toMap(ModelQuestions wrong) {
    return {
      _id: wrong.id,
      _elementarySchool: wrong.elementaryschool,
      _series: wrong.schoolyear,
      _displice: wrong.displice,
      _subject: wrong.subject,
      _question: wrong.question,
      _response: wrong.answer,
      _alternativeA: wrong.alternativeA,
      _alternativeB: wrong.alternativeB,
      _alternativeC: wrong.alternativeC,
      _alternativeD: wrong.alternativeD
    };
  }

  Future insertQuestionWrong(ModelQuestions datas) async {
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
        await db.query(_wrong, distinct: true, columns: [_displice]);

    for (var element in materia) {
      displice.add(element[_displice]);
    }
    //print(materia);
    print(displice);
    return displice;
  }

  Future<List> findForMatter_subjectAndLength(String displice) async {
    final Database db = await getConnection();

    listOfWrongSubjects.clear();
    subjects.clear();
    lengthSubject.clear();
    Map<String, dynamic> listSub;
    List<Map<String, dynamic>> subjectForMatter = await db.query(_wrong,
        where: 'displice = ?',
        whereArgs: [displice],
        distinct: true,
        columns: [_subject]);

    for (var sub in subjectForMatter) {
      subjects.add(sub[_subject]);
    }

    for (var lengthAssunto in subjects) {
      final List<Map<String, dynamic>> questions = await db
          .query(_wrong, where: 'subject = ? ', whereArgs: [lengthAssunto]);

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

  Future<List<Map<String, dynamic>>> findMatterAsWrong() async {
    final Database db = await getConnection();
    //List<String>? materias = [];
    //materias.clear();
    final List<Map<String, dynamic>> materia =
        await db.query(_wrong, distinct: true, columns: [_displice]);

    return materia;
  }

  Future removeQuestionsDetails(String question) async {
    for (var obj in listQuestionsWrongs) {
      if (obj['subject'] == question) {
        listQuestionsWrongs.removeWhere((item) => item['subject'] == question);
        break;
      }
    }
    print('listQuestions = $listQuestionsWrongs');
  }

  Future getQuestions(String assunto) async {
    final Database db = await getConnection();

    final List<Map<String, dynamic>> questions =
        await db.query(_wrong, where: 'subject = ? ', whereArgs: [assunto]);
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
