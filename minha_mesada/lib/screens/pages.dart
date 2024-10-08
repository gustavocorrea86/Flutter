import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_quizMath.dart';
import 'package:mongodb_api/database/dao_user.dart';
import 'package:mongodb_api/widgets/loading.dart';
import 'package:mongodb_api/widgets/box_alternativas.dart';
import 'package:mongodb_api/widgets/box_questions.dart';

import 'package:mongodb_api/widgets/screen_questions.dart';

class PagesQuestions extends StatefulWidget {
  const PagesQuestions({super.key});

  @override
  State<PagesQuestions> createState() => _PagesQuestionsState();
}

class _PagesQuestionsState extends State<PagesQuestions> {
  final controller = PageController();
  int activePage = 0;
  final Color green = Colors.green;
  final Color red = Colors.red;
  Future _future = DaoQuiz().findAll();
  int indexBottomNavigatorBar = 0;
  String userPoints = '0';

  Future<List<Map<String, dynamic>>> questions() async {
    if (_future != null) {
      _future = DaoQuiz().findAll();
    }
    return await _future;
  }

  Future points(String name) async {
    DaoQuizUser().findPoints(name);
    userPoints = DaoQuizUser.userPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            List<Map<String, dynamic>>? question = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.hasData && questions != null) {
              return Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: question!.length,
                    itemBuilder: (context, index) {
                      return ScreenQuestions(
                        BoxQuestions(question[index]['pergunta']),
                        BoxAlternatives(question[index]['alternativas'][0], 'A',
                            question[index]['resposta']),
                        BoxAlternatives(question[index]['alternativas'][1], 'B',
                            question[index]['resposta']),
                        BoxAlternatives(question[index]['alternativas'][2], 'C',
                            question[index]['resposta']),
                        BoxAlternatives(
                          question[index]['alternativas'][3],
                          'D',
                          question[index]['resposta'],
                        ),
                        controller,
                      );
                    },
                  ),
                ],
              );
            }
            return Center(child: Text('Nenhuma pergunta cadastrada'));
          }),
    );
  }
}
