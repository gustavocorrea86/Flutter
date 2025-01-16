import 'package:estudamais/widgets/screen_questions2.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/loading.dart';
import 'package:estudamais/widgets/box_alternativas.dart';
import 'package:estudamais/widgets/box_questions.dart';

import 'package:estudamais/widgets/screen_questions.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PageQuestionsBySchoolYear extends StatefulWidget {
  const PageQuestionsBySchoolYear({super.key});

  @override
  State<PageQuestionsBySchoolYear> createState() =>
      _PageQuestionsBySchoolYearState();
}

class _PageQuestionsBySchoolYearState extends State<PageQuestionsBySchoolYear> {
  Service service = Service();
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final Future future = Service().findQuestionsAllBySubjects(
        Provider.of<ModelPoints>(context, listen: false).titleSchoolYears,
        Provider.of<ModelPoints>(context, listen: false).titleDisplice,
        Provider.of<ModelPoints>(context, listen: false).subject);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ModelPoints>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: future,
            
            builder: (context, snapshot) {
              List<ModelQuestions>? question = snapshot.data;
              print(
                  '${value.subject} ${value.titleSchoolYears} ${value.titleDisplice}');
              // print('question: $question');
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
                              question[index].image,
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
                              question[index].elementarySchool,
                              question[index].schoolYear);
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
