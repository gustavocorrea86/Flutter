import 'package:flutter/material.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/loading.dart';
import 'package:estudamais/widgets/box_alternativas.dart';
import 'package:estudamais/widgets/box_questions.dart';

import 'package:estudamais/widgets/screen_questions.dart';
import 'package:provider/provider.dart';

class PagesQuestions extends StatefulWidget {
  const PagesQuestions({super.key});

  @override
  State<PagesQuestions> createState() => _PagesQuestionsState();
}

class _PagesQuestionsState extends State<PagesQuestions> {
  Service service = Service();
  final controller = PageController();
  
  final Future _future = Service().getQuestions();

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
              } else if (snapshot.hasData && question != null) {
                if (question.isNotEmpty) {
                  return Stack(
                    children: [
                      PageView.builder(
                        controller: controller,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: question.length,
                        itemBuilder: (context, index) {
                          return ScreenQuestions(
                              BoxQuestions(question[index].question),
                              BoxAlternatives(
                                  question[index].alternativeA,
                                  'A',
                                  question[index].answer,
                                  value.isAnswered,
                                  index),
                              BoxAlternatives(
                                  question[index].alternativeB,
                                  'B',
                                  question[index].answer,
                                  value.isAnswered,
                                  index),
                              BoxAlternatives(
                                  question[index].alternativeC,
                                  'C',
                                  question[index].answer,
                                  value.isAnswered,
                                  index),
                              BoxAlternatives(
                                  question[index].alternativeD,
                                  'D',
                                  question[index].answer,
                                  value.isAnswered,
                                  index),
                              controller,
                              question.length.toString(),
                              index,
                              question[index].displice,
                              question[index].subject,
                              question[index].id.toString(),
                              question[index].elementaryschool,
                              question[index].schoolyear);
                        },
                      ),
                    ],
                  );
                }
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sem perguntas cadastradas'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
