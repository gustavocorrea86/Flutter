import 'package:controle_uber/database/database.dart';
import 'package:controle_uber/models/model_datas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DaoDrivesControl {
  static const String _tableName = 'drivesControlTable';
  static const String _day = 'day';
  static const String _totalDay = 'totalDay';
  static const String _totalKm = 'totalKm';
  static const String _start = 'start';
  static const String _end = 'end';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_day TEXT,'
      '$_totalDay TEXT,'
      '$_totalKm TEXT,'
      '$_start TEXT,'
      '$_end TEXT)';

  Map<String, dynamic> toMap(ModelDatas datas) {
    return {
      _day: datas.dia,
      _totalDay: datas.totalDia,
      _totalKm: _totalKm,
      _start: _start,
      _end: _end
    };
  }

  save(ModelDatas datas) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> dataControl = toMap(datas);
    try {
      await db.insert(_tableName, dataControl);
      print('Dados salvo com sucesso');
    } catch (erro) {
      print('Erro ao salvar: $erro');
    }
  }

  findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> rows = await db.query(_tableName);
    print(rows);
  }
}





// import 'package:mongo_dart/mongo_dart.dart';

// const String userName = 'sushiemsuacasa';
// const String password = '4Ok5N6TSatZUao7o';
// const String adress = '@cluster0.s8r5t.mongodb.net/';
// const String dbUrl = 'mongodb+srv://$userName:$password$adress';

// class DaoDrivesControl {
//   Future getConnect() async {
//     List list = [];
//     try {
//       var db = await Db.create(
//           'mongodb+srv://sushiemsuacasa:4Ok5N6TSatZUao7o@cluster0.s8r5t.mongodb.net/? ');
//       await db.open();

//       var collection = db.collection('control');
//       await collection.find().forEach((res) {
//         list.add(res);
//        });
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }

//mongodb+srv://sushiemsuacasa:4Ok5N6TSatZUao7o@cluster0.s8r5t.mongodb.net/
