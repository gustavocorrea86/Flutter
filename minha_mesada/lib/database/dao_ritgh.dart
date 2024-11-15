import 'package:minha_mesada/database/database.dart';
import 'package:minha_mesada/models/model_right.dart';
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
  //static List<String> materias = [];
  static List<String> subjects = [];

  static List<String> lengthSubject = [];
  static List<Map<String, dynamic>> listOfRightSubject = [];
  static List<Map<String, dynamic>> listQuestionsRight = [];
  //static List<Map<String, dynamic>> subjectForMatter = [];

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

  Future<List> findForMatter_subjectAndLength(String matter) async {
    final Database db = await getConnection();

    listOfRightSubject.clear();
    subjects.clear();
    lengthSubject.clear();
    Map<String, dynamic> listSub;
    List<Map<String, dynamic>> subjectForMatter = await db.query(_right,
        where: 'materia = ?',
        whereArgs: [matter],
        distinct: true,
        columns: [_assunto]);

    for (var sub in subjectForMatter) {
      subjects.add(sub[_assunto]);
    }

    for (var lengthAssunto in subjects) {
      final List<Map<String, dynamic>> questions = await db
          .query(_right, where: 'assunto = ? ', whereArgs: [lengthAssunto]);

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
        await db.query(_right, where: 'assunto = ? ', whereArgs: [assunto]);

    print(questions);
  }

  Future removeQuestionsDetails(String question) async {
    for (var obj in listQuestionsRight) {
      if (obj['assunto'] == question) {
        listQuestionsRight.removeWhere((item) => item['assunto'] == question);
        break;
      }
    }
    print('listQuestions = $listQuestionsRight');
  }

  Future getQuestions(String assunto) async {
    final Database db = await getConnection();

    final List<Map<String, dynamic>> questions =
        await db.query(_right, where: 'assunto = ? ', whereArgs: [assunto]);
    for (var question in questions) {
      listQuestionsRight.add(question);
    }
    print('listQuestions = $listQuestionsRight');
    return listQuestionsRight;
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
    assuntos.clear();
    final List<Map<String, dynamic>> assunt =
        await db.query(_right, distinct: true, columns: [_assunto]);

    for (var element in assunt) {
      assuntos.add(element[_assunto]);
    }

    print('assuntos = $assuntos');

    return assuntos;
  }

  Future<List<Map<String, dynamic>>> findMatterAsRight() async {
    final Database db = await getConnection();
    //List<String>? materias;
    //materias.clear();
    final List<Map<String, dynamic>> materia =
        await db.query(_right, distinct: true, columns: [_materia]);

    // for (var element in materia) {
    //   materias.add(element[_materia]);
    // }
    
    //print(materia);
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
