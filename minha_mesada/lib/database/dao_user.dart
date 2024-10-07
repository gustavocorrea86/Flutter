import 'package:mongo_dart/mongo_dart.dart';

const userName = 'gucorreadev';
const password = 'ARF23KFF4bxWjlgp';
const dbAdress = '@cluster0.ddvmu.mongodb.net/';

const String dbUri = 'mongodb+srv://$userName:$password$dbAdress';

class DaoQuizUser {
  static String userPoints = '';
  Future getConnection() async {
    try {
      var db = await Db.create(dbUri);
      await db.open();
      var collection = db.collection('user');
      return collection;
    } catch (e) {
      print('Falha ao conectar ao banco: $e');
    }
  }

  Future findAllUser() async {
    var collection = await getConnection();
    try {
      await collection.find().forEach((v) {
        print(v);
      });
    } catch (e) {
      print('Falha ao buscar usuarios: $e');
    }
  }

  Future<String> addPoints(String name, int points) async {
    var collection = await getConnection();
    int? newPoints;
    try {
      await collection.find(where.eq('nome', name)).forEach((v) {
        newPoints = int.parse(v['pontos']) + points;
      });
      var findByName = await collection.findOne({'nome': name});
      findByName['pontos'] = newPoints.toString();
      await collection.replaceOne({'nome': name}, findByName);
    } catch (e) {
      print('Falha ao atualizar pontos: $e');
    }
    return newPoints.toString();
  }

  Future<String> findPoints(String name) async {
    var collection = await getConnection();

    try {
      await collection.find(where.eq('nome', name)).forEach((v) {
        userPoints = v['pontos'];
        print('$name = $userPoints pontos');
        
      });
    } catch (e) {
      print('Falha ao buscar pontos: $e');
    }
    return userPoints;
  }
}
// sushiemsuacasa
// 4Ok5N6TSatZUao7o