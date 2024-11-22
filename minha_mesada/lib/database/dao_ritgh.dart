import 'package:minha_mesada/database/database.dart';
import 'package:minha_mesada/models/model_questions.dart';
import 'package:sqflite/sqflite.dart';

class DaoRight {
  static const String _right = 'right';

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

  static List<String> assuntos = [];
  //static List<String> materias = [];
  static List<String> subjects = [];

  static List<String> lengthSubject = [];
  static List<Map<String, dynamic>> listOfRightSubject = [];
  static List<Map<String, dynamic>> listQuestionsRight = [];
  //static List<Map<String, dynamic>> subjectForMatter = [];

  static const String tableRight = 'CREATE TABLE $_right('
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

  Map<String, dynamic> toMap(ModelQuestions right) {
    return {
      _id: right.id,
      _elementarySchool: right.elementarySchool,
      _series: right.series,
      _displice: right.displice,
      _subject: right.subject,
      _question: right.question,
      _response: right.response,
      _alternativeA: right.alternativeA,
      _alternativeB: right.alternativeB,
      _alternativeC: right.alternativeC,
      _alternativeD: right.alternativeD
    };
  }

  Future insertQuestionRight(ModelQuestions datas) async {
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

  Future<List> findForMatter_subjectAndLength(String matter) async {
    final Database db = await getConnection();

    listOfRightSubject.clear();
    subjects.clear();
    lengthSubject.clear();
    Map<String, dynamic> listSub;
    List<Map<String, dynamic>> subjectForMatter = await db.query(_right,
        where: 'displice = ?',
        whereArgs: [matter],
        distinct: true,
        columns: [_subject]);

    for (var sub in subjectForMatter) {
      subjects.add(sub[_subject]);
    }

    for (var lengthAssunto in subjects) {
      final List<Map<String, dynamic>> questions = await db
          .query(_right, where: 'subject = ? ', whereArgs: [lengthAssunto]);

      lengthSubject.add(questions.length.toString());
    }

    for (var sub in subjects) {
      listSub = {
        'assunto': sub,
        'tamanho': lengthSubject[subjects.indexOf(sub)]
      };
      listOfRightSubject.add(listSub);
    }
    print(listOfRightSubject);
    //print('$subjects, $lengthSubject');
    return listOfRightSubject;
  }

  Future findForSubject(String assunto) async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> questions =
        await db.query(_right, where: 'subject = ? ', whereArgs: [assunto]);

    print(questions);
  }

  Future removeQuestionsDetails(String question) async {
    for (var obj in listQuestionsRight) {
      if (obj['subject'] == question) {
        listQuestionsRight.removeWhere((item) => item['subject'] == question);
        break;
      }
    }
    print('listQuestions = $listQuestionsRight');
  }

  Future getQuestions(String assunto) async {
    final Database db = await getConnection();

    final List<Map<String, dynamic>> questions =
        await db.query(_right, where: 'subject = ? ', whereArgs: [assunto]);
    for (var question in questions) {
      listQuestionsRight.add(question);
    }
    print('listQuestions = $listQuestionsRight');
    return listQuestionsRight;
  }

  Future findForSubjectOfRight(String value) async {
    final Database db = await getConnection();
    final List<Map<String, dynamic>> questions =
        await db.query(_right, distinct: true, columns: [_subject]);
    //await db.query(_right, where: 'assunto = ? ', whereArgs: [value]);

    listOfRightSubject.add(questions[0]);
    print('listOfRightSubject = $listOfRightSubject');
    return listOfRightSubject;
  }

  Future<List<String>> findSubjectAsRight() async {
    final Database db = await getConnection();
    assuntos.clear();
    final List<Map<String, dynamic>> assunt =
        await db.query(_right, distinct: true, columns: [_subject]);

    for (var element in assunt) {
      assuntos.add(element[_subject]);
    }

    print('assuntos = $assuntos');

    return assuntos;
  }

  Future<List<Map<String, dynamic>>> findMatterAsRight() async {
    final Database db = await getConnection();
    //List<String>? materias;
    //materias.clear();
    final List<Map<String, dynamic>> materia =
        await db.query(_right, distinct: true, columns: [_displice]);

    // for (var element in materia) {
    //   materias.add(element[_materia]);
    // }

    print(materia);
    // print('materias = $materias');

    return materia;
  }
}




// class ModelSubject {
//   String matter;
//   List<Map<String, dynamic>> subjectt = {

//   };
  
//   ModelSubject(this.matter,this.subjectt);
// }
