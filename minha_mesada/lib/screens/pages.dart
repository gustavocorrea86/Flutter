import 'package:flutter/material.dart';
import 'package:mongodb_api/models/models.dart';

import 'package:mongodb_api/service/service.dart';
import 'package:mongodb_api/widgets/loading.dart';
import 'package:mongodb_api/widgets/box_alternativas.dart';
import 'package:mongodb_api/widgets/box_questions.dart';

import 'package:mongodb_api/widgets/screen_questions.dart';
import 'package:provider/provider.dart';

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
  final Future _future = Service().getRequest();
  int indexBottomNavigatorBar = 0;
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
              List<Map<String, dynamic>>? question = snapshot.data;
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
                            BoxQuestions(question[index]['pergunta']),
                            BoxAlternatives(question[index]['alternativas'][0],
                                'A', question[index]['resposta'], value.isAnswered, index),
                            BoxAlternatives(question[index]['alternativas'][1],
                                'B', question[index]['resposta'], value.isAnswered, index),
                            BoxAlternatives(question[index]['alternativas'][2],
                                'C', question[index]['resposta'], value.isAnswered, index),
                            BoxAlternatives(
                              question[index]['alternativas'][3],
                              'D',
                              question[index]['resposta'], value.isAnswered, index
                            ),
                            controller,
                            question.length.toString(),
                            index, question[index]['materia'], question[index]['assunto']);
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
