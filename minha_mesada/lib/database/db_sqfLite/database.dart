import 'package:mongodb_api/database/db_sqfLite/dao_user_resum.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Future<Database> getConnectionTeste() async {
//   String path = join(await getDatabasesPath(), 'teste');
//   return await openDatabase(path, version: 1, onCreate: (db, version) {
//     return db.execute(DaoTeste.tableSqlTeste);
//   });
// }
Future<Database> getConnection() async {
  String path = join(await getDatabasesPath(), 'userDashboard');
  return await openDatabase(path, version: 1, onCreate: (db, version) {
    return db.execute(DaoUserResum.tableSql);
  });
}
