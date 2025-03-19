import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpandedIncorrects extends StatefulWidget {
  final List<String> discipline;
  final List<Map<String, dynamic>> resultQuestions;

  const ExpandedIncorrects(
      {required this.discipline, required this.resultQuestions, super.key});

  @override
  State<ExpandedIncorrects> createState() => _ExpandedIncorrectsState();
}

class _ExpandedIncorrectsState extends State<ExpandedIncorrects> {
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Selecione a disciplina e o assunto:',
              style: GoogleFonts.aboreto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          ExpansionPanelList.radio(
            expandIconColor: Colors.white,
            //materialGapSize: 10,
            expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 1),
            dividerColor: Colors.indigo,
            expansionCallback: (int index, bool enable) {
              //print('enable $enable e index $index');
              if (enable) {
                setState(
                  () {
                    // FAZ A CONSULTA PARA OBTER O ASSUNTO E O ANO ESCOLAR TANTO DAS CORRETAS COMO DAS INCORRETAS
                    QuestionsIncorrects().showSubjectsAndSchoolyeaIncorrects(
                      widget.discipline[index],
                      widget.resultQuestions,
                    );
                  },
                );
              }
            },
            children: widget.discipline.map<ExpansionPanelRadio>(
              (item) {
                return ExpansionPanelRadio(
                  backgroundColor: const Color.fromARGB(190, 197, 202, 233),
                  value: item,
                  headerBuilder: (context, bool isExpanded) {
                    return ListTile(
                      title: Text(item,
                          style: GoogleFonts.aboreto(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: QuestionsIncorrects
                          .mapListSubAndYearIncorrects.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            QuestionsIncorrects()
                                .getQuestionsCorrectsForSubjects(
                              QuestionsIncorrects
                                      .mapListSubAndYearIncorrects[index]
                                  ['subjects'],
                              QuestionsIncorrects
                                      .mapListSubAndYearIncorrects[index]
                                  ['schoolYear'],
                            );
                            value.showSubjects(true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(
                                      255, 101, 114, 185)),
                              child: ListTile(
                                minTileHeight: 10,
                                title: Text(
                                  QuestionsIncorrects
                                          .mapListSubAndYearIncorrects[index]
                                      ['subjects'],
                                  style: GoogleFonts.aboreto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  QuestionsIncorrects
                                          .mapListSubAndYearIncorrects[index]
                                      ['schoolYear'],
                                  style: GoogleFonts.aboreto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
          
                        // BoxSubjectsAndSchoolYear(
                        //   subject: QuestionsCorrects.mapListSubAndYearCorrects[index]
                        //       ['subjects'],
                        //   schoolYear: QuestionsCorrects.mapListSubAndYearCorrects[index]
                        //       ['schoolYear'],
                        // );
                      },
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      );
    });
  }
}
