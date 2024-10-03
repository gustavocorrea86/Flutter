import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_api/models/models.dart';

const userName = 'gucorreadev';
const password = 'ARF23KFF4bxWjlgp';
const dbAdress = '@cluster0.ddvmu.mongodb.net/';

const String dbUri = 'mongodb+srv://$userName:$password$dbAdress';

class DaoQuiz {
  Future getConnection() async {
    var db = await Db.create(dbUri);
    await db.open();
    var collection = db.collection('quizMath');
    return collection;
  }

  Future<List<Map<String,dynamic>>> findAll() async {
    var collection = await getConnection();
    List<Map<String,dynamic>> resultList = [];

    try {
      await collection.find().forEach((results) {
        resultList.add(results);
      });
    } catch (erro) {
      Exception('Falha ao buscar dados: $erro');
    }

    return resultList;
  }

  Future<List> findQuestions() async {
    var collection = await getConnection();
    List questions = [];
    try {
      await collection.find().forEach((res) {
        questions.add(res['pergunta']);
      });
    } catch (erro) {
      print('Falha ao buscar dados: $erro');
    }
    print(questions);
    return questions;
  }

  Future<String> findQuestionByNumber(int numberQuestion) async {
    var collection = await getConnection();
    List questions = [];
    String question = '';
    try {
      await collection.find().forEach((res) {
        questions.add(res['pergunta']);
        question = questions[numberQuestion];
      });
    } catch (erro) {
      print('Falha ao buscar dados: $erro');
    }
    // print(question);
    return question;
  }

  Future findAlternatives() async {
    var collection = await getConnection();
    List alternativas = [];
    try {
      await collection.find().forEach((res) {
        // print(res['alternativas']);
        alternativas.add(res['alternativas']);
      });
    } catch (erro) {
      print('Falha ao buscar dados: $erro');
    }
    print(alternativas[1]);
    return alternativas;
  }

  Future findNumberQuestion() async {
    var collection = await getConnection();
    List questions = [];
    try {
      await collection.find().forEach((res) {
        questions.add(res['questao']);
      });
    } catch (erro) {
      print('Falha ao buscar dados: $erro');
    }
    print(questions.length);
    return questions;
  }

  Future insertOne(ModelQuiz data) async {
    var collection = await getConnection();
    try {
      await collection.insertOne((data).toMap());
      print('Dados inseridos com sucesso');
    } catch (e) {
      print('Falha ao inserir dados: $e');
    }
  }

  Future insertMany() async {
    var collection = await getConnection();
    try {
      await collection.insertMany([
        {
          'pergunta': 'Qual é a capital de São Paulo?',
          'resposta': 'SãoPaulo',
          'alternativas': [
            'Rio de Janeiro',
            'Curitiba',
            'Salvador',
            'Minas Gerais'
          ]
        },
        {
          'pergunta': 'Qual é o maior planeta do sistema solar',
          'resposta': 'Jupiter',
          'alternativas': ['Terra', 'Plutão', 'Venus', 'Jupiter']
        },
      ]);
      print('Dados inseridos com sucesso');
    } catch (e) {
      print('Falha ao inserir dados: $e');
    }
  }

  Future getConnectionQuizPort() async {
    var db = await Db.create(
        'mongodb+srv://sushiemsuacasa:VKFMJ3c9chfO9dU5@cluster0.xxwr0.mongodb.net/');
    await db.open();
    await db.collection('movies').find().forEach((v) {
      print(v);
    });
    //o8mdsXeXrst51F5C
//mongodb+srv://sushiemsuacasa:<db_password>@cluster0.6xofd.mongodb.net/
  }
}


// ProjetoQuiz
//password: SGkpvxG5zbmh96Mw
//mongodb+srv://gucorreadev:SGkpvxG5zbmh96Mw@quiz.0nm70.mongodb.net/


//username: gucorreadev
//password: ARF23KFF4bxWjlgp

//189.34.167.113

//mongodb+srv://gucorreadev:3FLP52t14Wmu1LP5@cluster0.wg7bq.mongodb.net/
//3FLP52t14Wmu1LP5

//quiz_portugues
//9jsCiw1fVxwLr4xk
//mongodb+srv://gucorreadev:9jsCiw1fVxwLr4xk@cluster0.3yt9a.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0


//atGdn4CUtCUF5cYB api