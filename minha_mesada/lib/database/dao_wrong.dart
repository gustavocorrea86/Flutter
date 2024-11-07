import 'package:mongodb_api/database/database.dart';
import 'package:mongodb_api/models/model_wrongs.dart';
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
