import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/home/home.dart';
import 'package:estudamais/screens/screen_questions/questions_incorrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/widgets/background.dart';
import 'package:estudamais/widgets/button_next.dart';
import 'package:estudamais/screens/accumulated_incorrects/widgets/expanded_incorrects.dart';

import 'package:estudamais/widgets/map_selected_scrollable.dart';
import 'package:estudamais/widgets/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class AccumulatedWrongs extends StatefulWidget {
  const AccumulatedWrongs({super.key});

  @override
  State<AccumulatedWrongs> createState() => _AccumulatedWrongsState();
}

class _AccumulatedWrongsState extends State<AccumulatedWrongs> {
  bool checked = false;
  QuestionsIncorrects questionsIncorrectsDb = QuestionsIncorrects();

  onChecked() {
    setState(() {
      checked = !checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Respondidas incorretamente',
              style: GoogleFonts.aboreto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                //QuestionsCorrects.subjectsOfQuestionsCorrects.clear();
                //QuestionsIncorrects.subjectsOfQuestionsIncorrects.clear();
                Routes().popRoutes(context, const HomeScreen());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Background(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    child: Visibility(
                      visible: value.showBoxSubjects,
                      child: Column(
                        children: [
                          const Text(
                            'Assuntos selecionados',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          MapSelectedDisciplines(
                            textColor: Colors.white,
                            listMap:
                                QuestionsIncorrects.mapYearAndSubjectSelected,
                            direction: Axis.vertical,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              thickness: 3,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ExpandedIncorrects(
                    discipline: QuestionsIncorrects.listDisciplinesIncorrect,
                    resultQuestions:
                        QuestionsIncorrects.resultQuestionsIncorrect,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (QuestionsIncorrects
                          .mapYearAndSubjectSelected.isEmpty) {
                        showSnackBar(
                          context,
                          'Selecione a disciplina e o assunto para continuar.',
                          Colors.red,
                        );
                      } else {
                        Routes().pushRoute(
                            context, const PageQuestionsIncorrects());
                        QuestionsIncorrects().getResultQuestionsIncorrects();
                      }
                    },
                    child: const ButtonNext(textContent: 'Mostrar questões'),
                  ),
                ],
              ),
            ),
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: GestureDetector(
          //   onTap: () {
          //     if (QuestionsIncorrects.mapYearAndSubjectSelected.isEmpty) {
          //       showSnackBar(
          //         context,
          //         'Selecione a disciplina e o assunto para continuar.',
          //         Colors.red,
          //       );
          //     } else {
          //       Routes().pushRoute(context, const PageQuestionsIncorrects());
          //       QuestionsIncorrects().getResultQuestionsIncorrects();
          //     }
          //   },
          //   child: const ButtonNext(textContent: 'Mostrar questões'),
          // ),
        );
      },
    );
  }
}
