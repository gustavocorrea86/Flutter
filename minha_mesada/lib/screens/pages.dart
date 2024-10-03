import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_quizMath.dart';
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

  Future<List<Map<String, dynamic>>> questions() async {
    if (_future != null) {
      _future = DaoQuiz().findAll();
    }
    return await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        actions: [
          Container(
            color: Colors.indigoAccent,
            alignment: Alignment.center,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
        automaticallyImplyLeading: false,
        leadingWidth: 50,
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            List<Map<String, dynamic>>? question = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Carregando...')
                  ],
                ),
              );
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
                        BoxAlternatives(question[index]['alternativas'][3], 'D',
                            question[index]['resposta']),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 270,
                    child: ElevatedButton(
                        onPressed: () {
                          print(_future);
                          // controller.animateToPage(1,
                          //     duration: Duration(seconds: 1), curve: Curves.ease);
                          if (activePage < question.length - 1) {
                            controller.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          }
                        },
                        child: Text('Próximo')),
                  )
                ],
              );
            }
            return Center(child: Text('Nenhuma pergunta cadastrada'));
          }),
    );
  }
}
// PageView(
//   controller: controller,
//   physics: NeverScrollableScrollPhysics(),
//   children: [
//     ScreenQuestions(
//         BoxQuestions('Quanto é 4 + 4 ?'),
//         BoxAlternatives(green, '8', 'A'),
//         BoxAlternatives(red, '5', 'B'),
//         BoxAlternatives(red, '9', 'C'),
//         BoxAlternatives(red, '6', 'D'),
//         controller,
//         1),
//   ],
// ),
