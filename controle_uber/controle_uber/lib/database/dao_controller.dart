import 'package:mongo_dart/mongo_dart.dart';

const String userName = 'sushiemsuacasa';
const String password = '4Ok5N6TSatZUao7o';
const String adress = '@cluster0.s8r5t.mongodb.net/';
const String dbUrl = 'mongodb+srv://$userName:$password$adress';

class DaoDrivesControl {
  Future getConnect() async {
    List list = [];
    try {
      var db = await Db.create(
          'mongodb+srv://sushiemsuacasa:4Ok5N6TSatZUao7o@cluster0.s8r5t.mongodb.net/? ');
      await db.open();

      var collection = db.collection('control');
      await collection.find().forEach((res) {
        list.add(res);
       });
    } catch (e) {
      print('Error: $e');
    }
  }
}

//mongodb+srv://sushiemsuacasa:4Ok5N6TSatZUao7o@cluster0.s8r5t.mongodb.net/
