import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/home/home.dart';
import 'package:estudamais/screens/screen_questions/questions_incorrects.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/widgets/background.dart';
import 'package:estudamais/widgets/button_next.dart';
import 'package:estudamais/widgets/expanded_subjects.dart';
import 'package:estudamais/widgets/list_selected_scrollable.dart';
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
                QuestionsCorrects.subjectsOfQuestionsCorrects.clear();
                QuestionsIncorrects.subjectsOfQuestionsIncorrects.clear();
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
              child: SizedBox.expand(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: QuestionsIncorrects
                                  .subjectsOfQuestionsIncorrects.isNotEmpty
                              ? value.showBoxSubjects
                              : false,
                          child: Column(
                            children: [
                              const Text(
                                'Assuntos selecionados',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              ListSelectedDisciplines(
                                textColor: Colors.white,
                                list: QuestionsIncorrects
                                    .subjectsOfQuestionsIncorrects
                                    .toList(),
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
                      ],
                    ),
                    ExpandedSubjects(
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
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: GestureDetector(
            onTap: () {
              if (QuestionsIncorrects.subjectsOfQuestionsIncorrects.isEmpty) {
                showSnackBar(
                  context,
                  'Selecione a disciplina e o assunto para continuar.',
                  Colors.red,
                );
              } else {
                Routes().pushRoute(context, const PageQuestionsIncorrects());
              }
            },
            child: const ButtonNext(textContent: 'Mostrar questões'),
          ),
        );
      },
    );
  }
}
