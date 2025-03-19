import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/home/home.dart';
import 'package:estudamais/screens/screen_questions/questions_corrects.dart';
import 'package:estudamais/service/questions_corrects.dart';

import 'package:estudamais/widgets/background.dart';
import 'package:estudamais/widgets/button_next.dart';
import 'package:estudamais/screens/accumulated_corrects/widgets/expanded_corrects.dart';

import 'package:estudamais/widgets/map_selected_scrollable.dart';
import 'package:estudamais/widgets/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class AccumulatedRight extends StatefulWidget {
  const AccumulatedRight({super.key});

  @override
  State<AccumulatedRight> createState() => _AccumulatedRightState();
}

class _AccumulatedRightState extends State<AccumulatedRight> {
  QuestionsCorrects questionsCorrectsDb = QuestionsCorrects();
  ScrollController scrollController = ScrollController();
  bool enable = false;
  ExpansionTileController? controleExpansion = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Respondidas corretamente',
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
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: value.showBoxSubjects,
                      child: Column(
                        children: [
                          Text('Assuntos selecionados:',
                              style: GoogleFonts.aboreto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          MapSelectedDisciplines(
                            textColor: Colors.white,
                            listMap:
                                QuestionsCorrects.mapYearAndSubjectSelected,
                            direction: Axis.vertical,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ExpandedCorrects(
                    discipline: QuestionsCorrects.listDisciplinesCorrect,
                    resultQuestions: QuestionsCorrects.resultQuestionsCorrect,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 2,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (QuestionsCorrects.mapYearAndSubjectSelected.isEmpty) {
                        showSnackBar(
                          context,
                          'Selecione a disciplina e o assunto para continuar.',
                          Colors.red,
                        );
                      } else {
                        QuestionsCorrects().getResultQuestionsCorrects();
                        Routes()
                            .pushRoute(context, const PageQuestionsCorrects());
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
          // floatingActionButton:
          // GestureDetector(
          //   onTap: () {
          //     if (QuestionsCorrects.mapYearAndSubjectSelected.isEmpty) {
          //       showSnackBar(
          //         context,
          //         'Selecione a disciplina e o assunto para continuar.',
          //         Colors.red,
          //       );
          //     } else {
          //       QuestionsCorrects().getResultQuestionsCorrects();
          //       Routes().pushRoute(context, const PageQuestionsCorrects());
          //     }
          //   },
          //   child: const ButtonNext(textContent: 'Mostrar questões'),
          // ),
        );
      },
    );
  }
}
