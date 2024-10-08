import 'package:controle_uber/database/dao_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  String path = join(await getDatabasesPath(), 'drivesControl');
  return await openDatabase(path, version: 1, onCreate: (db, version) {
    return db.execute(DaoDrivesControl.tableSql);
  });
}

