import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/widgets/expanded_subjects.dart';
import 'package:estudamais/widgets/list_selected_scrollable.dart';
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
            title: const Text('Respondidas corretamente'),
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                QuestionsCorrects.subjectsOfQuestionsCorrects.clear();
                QuestionsIncorrects.subjectsOfQuestionsIncorrects.clear();
                Navigator.popAndPushNamed(context, 'home');
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('./assets/images/ball-7280265_640.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        Visibility(
                          visible: QuestionsCorrects
                                  .subjectsOfQuestionsCorrects.isNotEmpty
                              ? value.showBoxSubjects
                              : false,
                          child: Column(
                            children: [
                              Text('Assuntos selecionados',
                                  style: GoogleFonts.aboreto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              ListSelectedDisciplines(
                                textColor: Colors.white,
                                list: QuestionsCorrects
                                    .subjectsOfQuestionsCorrects
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
                      discipline: QuestionsCorrects.listDisciplinesCorrect,
                      resultQuestions: QuestionsCorrects.resultQuestionsCorrect,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 3,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Mostrar questões')),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
