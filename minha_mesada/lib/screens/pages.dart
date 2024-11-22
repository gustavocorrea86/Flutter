import 'package:flutter/material.dart';
import 'package:minha_mesada/models/model_questions.dart';
import 'package:minha_mesada/models/models.dart';

import 'package:minha_mesada/service/service.dart';
import 'package:minha_mesada/widgets/loading.dart';
import 'package:minha_mesada/widgets/box_alternativas.dart';
import 'package:minha_mesada/widgets/box_questions.dart';

import 'package:minha_mesada/widgets/screen_questions.dart';
import 'package:provider/provider.dart';

class PagesQuestions extends StatefulWidget {
  const PagesQuestions({super.key});

  @override
  State<PagesQuestions> createState() => _PagesQuestionsState();
}

class _PagesQuestionsState extends State<PagesQuestions> {
  final controller = PageController();
  //int activePage = 0;
  // final Color green = Colors.green;
  // final Color red = Colors.red;
  final Future _future = Service().getQuestions();
  //int indexBottomNavigatorBar = 0;
  // String userPoints = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ModelPoints>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              List<ModelQuestions>? question = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else if (snapshot.hasData) {
                // && questions != null
                return Stack(
                  children: [
                    PageView.builder(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: question!.length,
                      itemBuilder: (context, index) {
                        return ScreenQuestions(
                            BoxQuestions(question[index].question),
                            BoxAlternatives(question[index].alternativeA,
                                'A', question[index].response, value.isAnswered, index),
                            BoxAlternatives(question[index].alternativeB,
                                'B', question[index].response, value.isAnswered, index),
                            BoxAlternatives(question[index].alternativeC,
                                'C', question[index].response, value.isAnswered, index),
                            BoxAlternatives(
                              question[index].alternativeD,
                              'D',
                              question[index].response, value.isAnswered, index
                            ),
                            controller,
                            question.length.toString(),
                            index, question[index].displice, question[index].subject, question[index].id, question[index].elementarySchool, question[index].series);
                      },
                    ),
                  ],
                );
              }
              return const Center(child: Text('Nenhuma pergunta cadastrada'));
            },
          );
        },
      ),
    );
  }
}
