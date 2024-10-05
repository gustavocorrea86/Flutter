import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_quizMath.dart';
import 'package:mongodb_api/models/models.dart';

class RegisterQuestions extends StatelessWidget {
  RegisterQuestions({super.key});
  final TextEditingController question = TextEditingController();
  final TextEditingController response = TextEditingController();
  final TextEditingController altA = TextEditingController();
  final TextEditingController altB = TextEditingController();
  final TextEditingController altC = TextEditingController();
  final TextEditingController altD = TextEditingController();
  List<String> alternativas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Questões'),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: question,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Pergunta')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: response,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Resposta')),
              ),
            ),
            Text('Alternativas'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: altA,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('A')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: altB,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('B')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: altC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('C')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: altD,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('D')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  alternativas = [altA.text, altB.text, altC.text, altD.text];
                  DaoQuiz().insertOne(
                      ModelQuiz(question.text, response.text, alternativas));
                      question.clear();
                      response.clear();
                      altA.clear();
                      altB.clear();
                      altC.clear();
                      altD.clear();
                  
                },
                child: Text('Cadastrar'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                   
                  },
                  child: Text('Printar')),
            )
          ],
        ),
      ),
    );
  }
}
