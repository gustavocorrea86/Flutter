import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/screens/page_transition.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_alternatives_incorrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/screens/screen_questions/widgets/box_questions.dart';

import 'package:estudamais/screens/screen_questions/widgets/box_screen_questions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PageQuestionsIncorrects extends StatefulWidget {
  const PageQuestionsIncorrects({super.key});

  @override
  State<PageQuestionsIncorrects> createState() =>
      _PageQuestionsIncorrectsState();
}

class _PageQuestionsIncorrectsState extends State<PageQuestionsIncorrects> {
  //Service service = Service();
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ModelPoints>(
        builder: (context, value, child) {
          return PageView.builder(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: QuestionsIncorrects.resultQuestions.length,
            itemBuilder: (context, index) {
              return ScreenQuestions(
                boxQuestions: BoxQuestions(
                    QuestionsIncorrects.resultQuestions[index].question),
                image: QuestionsIncorrects.resultQuestions[index].image,
                boxAlternativesA: BoxAlternativesIncorrects(
                  QuestionsIncorrects.resultQuestions[index].alternativeA,
                  'A',
                  QuestionsIncorrects.resultQuestions[index].answer,
                  value.isAnswered,
                  index,
                  QuestionsIncorrects.resultQuestions[index].id.toString(),
                ),
                boxAlternativesB: BoxAlternativesIncorrects(
                  QuestionsIncorrects.resultQuestions[index].alternativeB,
                  'B',
                  QuestionsIncorrects.resultQuestions[index].answer,
                  value.isAnswered,
                  index,
                  QuestionsIncorrects.resultQuestions[index].id.toString(),
                ),
                boxAlternativesC: BoxAlternativesIncorrects(
                  QuestionsIncorrects.resultQuestions[index].alternativeC,
                  'C',
                  QuestionsIncorrects.resultQuestions[index].answer,
                  value.isAnswered,
                  index,
                  QuestionsIncorrects.resultQuestions[index].id.toString(),
                ),
                boxAlternativesD: BoxAlternativesIncorrects(
                  QuestionsIncorrects.resultQuestions[index].alternativeD,
                  'D',
                  QuestionsIncorrects.resultQuestions[index].answer,
                  value.isAnswered,
                  index,
                  QuestionsIncorrects.resultQuestions[index].id.toString(),
                ),
                controller: controller,
                indexQuestion: index,
                discipline:
                    QuestionsIncorrects.resultQuestions[index].discipline,
                subject: QuestionsIncorrects.resultQuestions[index].subject,
                id: QuestionsIncorrects.resultQuestions[index].id.toString(),
                elementarySchool:
                    QuestionsIncorrects.resultQuestions[index].elementarySchool,
                schoolYear:
                    QuestionsIncorrects.resultQuestions[index].schoolYear,
                textButton: TextButton(
                  onPressed: () {
                   
                    //Routes().pushRouteFade(context, const TransitionPage());
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(seconds: 1),
                          child: const TransitionPage()),
                      (route) => false,
                    );

                    // atualiza os pontos das corretas na homoScreen
                    Provider.of<ModelPoints>(context, listen: false)
                        .uptadeCorrects(DaoUserResum.listIdCorrects.length);
                        // atualiza os pontos das incorretas na homoScreen
                    Provider.of<ModelPoints>(context, listen: false)
                        .updateIncorrects(DaoUserResum.listIdIncorrects.length);
                  },
                  child: const Text(
                    'Sair',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
