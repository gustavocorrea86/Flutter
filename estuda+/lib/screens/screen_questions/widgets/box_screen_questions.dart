import 'dart:typed_data';
import 'package:estudamais/service/service.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_type_question.dart';
import 'package:estudamais/screens/screen_questions/widgets/pointsAndErrors.dart';
import 'package:provider/provider.dart';

class ScreenQuestions extends StatefulWidget {
  final Widget boxQuestions;
  final Uint8List image;
  final Widget boxAlternativesA;
  final Widget boxAlternativesB;
  final Widget boxAlternativesC;
  final Widget boxAlternativesD;
  final PageController controller;
  final String qdtQuestoes;
  final int question;
  final String matter;
  final String subject;
  final String id;
  final String elementarySchool;
  final String series;

  const ScreenQuestions(
      this.boxQuestions,
      this.image,
      this.boxAlternativesA,
      this.boxAlternativesB,
      this.boxAlternativesC,
      this.boxAlternativesD,
      this.controller,
      this.qdtQuestoes,
      this.question,
      this.matter,
      this.subject,
      this.id,
      this.elementarySchool,
      this.series,
      {super.key});

  @override
  State<ScreenQuestions> createState() => _ScreenQuestionsState();
}

class _ScreenQuestionsState extends State<ScreenQuestions> {
  Color corAlternativa = Colors.white;
  double heightAnswered = 0;
  DaoUserResum databeseUserResum = DaoUserResum();
  // DaoRight databaseRight = DaoRight();
  // DaoWrong databaseWrongs = DaoWrong();
  double heightImage = 0;
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('./assets/images/ball-7280265_640.jpg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 60.0, right: 8.0, bottom: 8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 3),
                              blurRadius: 1,
                              spreadRadius: 1)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ID Questão ${widget.id}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),
                              ),
                              PointsAndErrors()
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black26,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: BoxTypeQuestion(
                            widget.elementarySchool,
                            widget.matter,
                            widget.series,
                            widget.subject,
                          ),
                        ),
                        const Divider(
                          color: Colors.black26,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        widget.boxQuestions,
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.memory(widget.image,
                              width: MediaQuery.of(context).size.width,
                              errorBuilder: (context, error, stackTrace) {
                            //print('Without image or image is with error');
                            return Container();
                          }),
                        ),
                        widget.boxAlternativesA,
                        widget.boxAlternativesB,
                        widget.boxAlternativesC,
                        widget.boxAlternativesD,
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.black26,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Center(
                            child: SizedBox(
                              height: value.boxIsAnswered,
                              child: const Text(
                                'Ops, essa você já respondeu!',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 145, 18, 9)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //print('teste');
                        widget.controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.ease);
                        value.answered(false);
                        value.actBoxAnswered(0);
                        print('value.answered ${value.answered}');
                      },
                      child: const Text('Próximo'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                widget.controller.animateToPage(
                                    widget.question - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: const Text(
                                'Voltar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            TextButton(
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
                                Navigator.popAndPushNamed(
                                    context, 'loadingNextPage');
                                // QuestionsCorrects().getQuestionsCorrects();
                                // QuestionsIncorrects().getQuestionsIncorrects();
                              },
                              child: const Text(
                                'Sair',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
