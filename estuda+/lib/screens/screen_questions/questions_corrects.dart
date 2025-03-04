import 'package:estudamais/screens/screen_questions/widgets/box_alternatives_corrects.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/service/service.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_questions.dart';

import 'package:estudamais/screens/screen_questions/widgets/box_screen_questions.dart';
import 'package:provider/provider.dart';

class PageQuestionsCorrects extends StatefulWidget {
  const PageQuestionsCorrects({super.key});

  @override
  State<PageQuestionsCorrects> createState() => _PageQuestionsCorrectsState();
}

class _PageQuestionsCorrectsState extends State<PageQuestionsCorrects> {
  Service service = Service();
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
            itemCount: QuestionsCorrects.resultQuestions.length,
            itemBuilder: (context, index) {
              return ScreenQuestions(
                boxQuestions: BoxQuestions(
                    //mostra a pergunta
                    QuestionsCorrects.resultQuestions[index].question),
                //mostra a imagem se tiver
                image: QuestionsCorrects.resultQuestions[index].image,
                boxAlternativesA: BoxAlternativesCorrects(
                  // mostra a alternativa
                  QuestionsCorrects.resultQuestions[index].alternativeA,
                  'A',
                  //pega a resposta para comparar com a resposta da alternativa
                  QuestionsCorrects.resultQuestions[index].answer,
                  // se ja foi respondida
                ),
                boxAlternativesB: BoxAlternativesCorrects(
                  QuestionsCorrects.resultQuestions[index].alternativeB,
                  'B',
                  QuestionsCorrects.resultQuestions[index].answer,
                ),
                boxAlternativesC: BoxAlternativesCorrects(
                  QuestionsCorrects.resultQuestions[index].alternativeC,
                  'C',
                  QuestionsCorrects.resultQuestions[index].answer,
                ),
                boxAlternativesD: BoxAlternativesCorrects(
                  QuestionsCorrects.resultQuestions[index].alternativeD,
                  'D',
                  QuestionsCorrects.resultQuestions[index].answer,
                ),
                controller: controller,
                indexQuestion: index,
                discipline: QuestionsCorrects.resultQuestions[index].discipline,
                subject: QuestionsCorrects.resultQuestions[index].subject,
                id: QuestionsCorrects.resultQuestions[index].id.toString(),
                elementarySchool:
                    QuestionsCorrects.resultQuestions[index].elementarySchool,
                schoolYear: QuestionsCorrects.resultQuestions[index].schoolYear,
                title: 'Questões Corretas',
              );
            },
          );
        },
      ),
    );
  }
}
