import 'dart:async';

import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/screens/page_transition.dart';
import 'package:estudamais/screens/screen_questions/widgets/pointsAndErrors.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/service/service.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_alternativas.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_questions.dart';

import 'package:estudamais/screens/screen_questions/widgets/box_screen_questions.dart';
import 'package:page_transition/page_transition.dart';
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
  Timer? timer;

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
            itemCount: Service.resultQuestionsBySubjectsAndSchoolYear.length,
            itemBuilder: (context, index) {
              return ScreenQuestions(
                boxQuestions: BoxQuestions(Service
                    .resultQuestionsBySubjectsAndSchoolYear[index].question),
                image:
                    Service.resultQuestionsBySubjectsAndSchoolYear[index].image,
                boxAlternativesA: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      .alternativeA,
                  'A',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].answer,
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].id
                      .toString(),
                ),
                boxAlternativesB: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      .alternativeB,
                  'B',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].answer,
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].id
                      .toString(),
                ),
                boxAlternativesC: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      .alternativeC,
                  'C',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].answer,
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].id
                      .toString(),
                ),
                boxAlternativesD: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      .alternativeD,
                  'D',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].answer,
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index].id
                      .toString(),
                ),
                controller: controller,
                indexQuestion: index,
                discipline: Service
                    .resultQuestionsBySubjectsAndSchoolYear[index].discipline,
                subject: Service
                    .resultQuestionsBySubjectsAndSchoolYear[index].subject,
                id: Service.resultQuestionsBySubjectsAndSchoolYear[index].id
                    .toString(),
                elementarySchool: Service
                    .resultQuestionsBySubjectsAndSchoolYear[index]
                    .elementarySchool,
                schoolYear: Service
                    .resultQuestionsBySubjectsAndSchoolYear[index].schoolYear,
                correctsAndIncorrects: const PointsAndErrors(),
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
