
import 'package:estudamais/database/dao_user_resum.dart';


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getConnection() async {
  String path = join(await getDatabasesPath(), 'testeDb13');
  return await openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute(DaoUserResum.tableUser);
    print('Tabelas criadas com sucesso!');
  });
}
