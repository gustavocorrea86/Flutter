import 'package:mongodb_api/database/db_sqfLite/database.dart';
import 'package:mongodb_api/models/models_user_resum.dart';
import 'package:sqflite/sqflite.dart';

class DaoUserResum {
  static const String _tableName = 'resumTable ';

  static const String _name = 'name';
  static const String _lastName = 'lastName';
  static const String _age = 'age';
  static const String _elementarySchool = 'elementarySchool';
  static const String _grade = 'grade';
  static const String _monthPoints = 'monthPoints';
  static const String _totalPoints = 'totalPoints';
  static const String _totalHits = 'totalHits';
  static const String _monthHits = 'monthHits';
  static const String _totalError = 'totalError';
  static const String _monthError = 'monthError';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT,'
      '$_lastName TEXT,'
      '$_age TEXT,'
      '$_elementarySchool TEXT,'
      '$_grade TEXT,'
      '$_monthPoints TEXT,'
      '$_totalPoints TEXT,'
      '$_totalHits TEXT,'
      '$_monthHits TEXT,'
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
      _totalPoints: resumUser.totalPoints,
      _totalHits: resumUser.totalHits,
      _monthHits: resumUser.monthHits,
      _totalError: resumUser.totalErrors,
      _monthError: resumUser.monthErrors,
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

  Future close() async{
    final db = await getConnection();
    try{
      await db.close();
      print('Banco de dados fechado com sucesso');
    }
    catch (e) {
      print('Erro ao fechar o banco de dados: $e');
    }
  }

  Future delete()async{
    final db = await getConnection();
    try {
      await db.delete(_tableName);
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }
  Future deleteDatabse()async{
    final db = await getConnection();
    try {
      await db.database;
      print('Todos os dados foram excluídos');
    } catch (e) {
      print('Erro ao excluir dados: $e');
    }
  }
}

// class ModelTeste {
//   final String nome;
//   final String idade;
//   ModelTeste({required this.nome, required this.idade});
// }

// class DaoTeste {
//   static const String _tableTeste = 'tableTeste';
//   static const String _nome = 'nome';
//   static const String _idade = 'idade';

//   static const String tableSqlTeste = 'CREATE TABLE $_tableTeste('
//       '$_nome TEXT,'
//       '$_idade TEXT)';

//   Map<String, dynamic> toMap(ModelTeste teste) {
//     return {
//       'nome': teste.nome,
//       'idade': teste.idade,
//     };
//   }

//   Future saveTeste(ModelTeste datas) async {
//     final Database db = await getConnectionTeste();
//     final Map<String, dynamic> teste = toMap(datas);
//     try {
//       await db.insert(_tableTeste, teste);
//       print('Teste salvo com sucesso');
//     } catch (e) {
//       print('Erro ao salvar teste: $e');
//     }
//   }
//   Future delete()async{
//     final Database db = await getConnectionTeste();
//     try {
//       await db.delete(_tableTeste);
//       print('Teste deletado com sucesso');
//     } catch (e) {
//       print('Erro ao deletar teste: $e');
//     }
//   }
// }
