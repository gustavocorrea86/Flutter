import 'package:mongodb_api/database/dao_ritgh.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/database/dao_wrong.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getConnection() async {
  String path = join(await getDatabasesPath(), 'test2.db');
  return await openDatabase(path, version: 1, onCreate: (db, version) {
    List tables = [
      DaoUserResum.tableUser,
      DaoRight.tableRight,
      DaoWrong.tableWrong
    ];
    for (var table in tables) {
      db.execute(table);
    }
  });
}
