import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/show_subjects.dart';
import 'package:estudamais/widgets/box_subjects.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpandedSubjects extends StatefulWidget {
  final List<String> discipline;
  final List<Map<String, dynamic>> resultQuestions;
  

  const ExpandedSubjects(
      {required this.discipline, required this.resultQuestions, super.key});

  @override
  State<ExpandedSubjects> createState() => _ExpandedSubjectsState();
}

class _ExpandedSubjectsState extends State<ExpandedSubjects> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Selecione a disciplina e o assunto:',
              style: GoogleFonts.aboreto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionPanelList.radio(
              expandIconColor: Colors.white,
              materialGapSize: 10,
              expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 5),
              dividerColor: Colors.indigo,
              //expandedHeaderPadding: const EdgeInsets.all(1),
              expansionCallback: (int index, bool enable) {
                print('enable $enable e index $index');
                if (enable) {
                  setState(
                    () {
                      // FAZ A CONSULTA PARA OBTER O ASSUNTO E O ANO ESCOLAR TANTO DAS CORRETAS COMO DAS INCORRETAS
                      ShowSubjects().showSubjectsAndSchoolyeaAll(
                          widget.discipline[index], widget.resultQuestions);
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
                      print(isExpanded);
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
                        itemCount: ShowSubjects.mapListSubAndYear.length,
                        itemBuilder: (context, int index) {
                          return BoxSubjectsAndSchoolYear(
                            subject: ShowSubjects.mapListSubAndYear[index]
                                ['subjects'],
                            schoolYear: ShowSubjects.mapListSubAndYear[index]
                                ['schoolYear'],
                          );
                        },
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      );
    });
  }
}
