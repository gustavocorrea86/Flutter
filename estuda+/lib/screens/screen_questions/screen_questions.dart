import 'package:estudamais/screens/loading_next_page.dart';
import 'package:estudamais/screens/screen_questions/widgets/pointsAndErrors.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/service/service.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_alternativas.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_questions.dart';

import 'package:estudamais/screens/screen_questions/widgets/box_screen_questions.dart';
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
                    .resultQuestionsBySubjectsAndSchoolYear[index]['question']),
                image: Service.resultQuestionsBySubjectsAndSchoolYear[index]
                    ['image'],
                boxAlternativesA: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['alternativeA'],
                  'A',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['answer'],
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                      .toString(),
                ),
                boxAlternativesB: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['alternativeB'],
                  'B',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['answer'],
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                      .toString(),
                ),
                boxAlternativesC: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['alternativeC'],
                  'C',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['answer'],
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                      .toString(),
                ),
                boxAlternativesD: BoxAlternatives(
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['alternativeD'],
                  'D',
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['answer'],
                  value.isAnswered,
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                      .toString(),
                ),
                controller: controller,
               
                indexQuestion: index,
                discipline: Service
                    .resultQuestionsBySubjectsAndSchoolYear[index]['displice'],
                subject: Service.resultQuestionsBySubjectsAndSchoolYear[index]
                    ['subject'],
                id: Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                    .toString(),
                elementarySchool:
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['elementarySchool'],
                schoolYear:
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['schoolYear'],
                        correctsAndIncorrects: const PointsAndErrors(),
                        textButton: TextButton(
                              onPressed: () {
                                //limpa as questões obtidas por disciplina
                                Service.questionsByDiscipline.clear();
                                // limpa a list onde mostra as disciplinas selecionadas
                                Service.listSelectedDisciplines.clear();
                                // limpa as questões obtidas da busca por ano escolar
                                Service.questionsBySchoolYear.clear();
                                // limpa a list de disciplina, ano e assunto que foram obtidas da busca por ano selecionado
                                Service.schoolYearAndSubjects.clear();
                                // limpa list que onde mostra os anos selecionados
                                Service.listSelectedSchoolYear.clear();
                                // limpa a list da busca geral
                                Service.resultQuestionsBySubjectsAndSchoolYear
                                    .clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoadingNextPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sair',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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
