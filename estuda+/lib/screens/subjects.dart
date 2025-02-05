import 'package:estudamais/widgets/animated_button_retangulare.dart';
import 'package:estudamais/widgets/listSelected_scrollable.dart';
import 'package:estudamais/widgets/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Subjects extends StatefulWidget {
  Subjects({super.key});
  bool backButton = false;
  double shadowBox = 10;
  Color colorShadow = Colors.black87;

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final Service service = Service();

  final ScrollController scrollControllerSubjects = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, 'schoolYear');
                Service.questionsBySchoolYear.clear();
                Service.schoolYearAndSubjects.clear();
                Service.listSelectedSchoolYear.clear();
                //Navigator.pushNamed(context, 'home');
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Disciplina/Ano escolar/Assunto',
            style: GoogleFonts.aboreto(fontSize: 16),
          ),
        ),
        body: LayoutBuilder(builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          return Stack(
            children: [
              SizedBox.expand(
                child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                    fit: BoxFit.cover),
              ),
              ListView(
                children: [
                  ListSelectedDisciplines(
                    list: Service.listSelectedDisciplines,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(),
                  ),
                  ListSelectedDisciplines(
                    list: Service.listSelectedSchoolYear,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Selecione os assuntos:',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                          minHeight: 0,
                          maxHeight: 400),
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, right: 1),
                        child: Scrollbar(
                          controller: scrollControllerSubjects,
                          thumbVisibility: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollControllerSubjects,
                            itemCount: Service.schoolYearAndSubjects.length,
                            itemBuilder: (context, int index) {
                              return AnimatedButtonRectangular(
                                title: Service.schoolYearAndSubjects[index]
                                    ['subjects'],
                                onTap: () {
                                  service.getQuestionsAllBySubjectsAndSchoolYea(
                                      Service.schoolYearAndSubjects[index]
                                          ['schoolYear'],
                                      Service.schoolYearAndSubjects[index]
                                          ['subjects'],
                                      Service.schoolYearAndSubjects[index]
                                          ['disciplines']);
                                },
                                leading: Service.schoolYearAndSubjects[index]
                                    ['disciplines'],
                                tralling: Service.schoolYearAndSubjects[index]
                                    ['schoolYear'],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.amber,
                    child: TextButton(
                      onPressed: () {
                        if (Service
                            .resultQuestionsBySubjectsAndSchoolYear.isEmpty) {
                          showSnackBar(
                            context,
                            'Selecione o assunto para concluir.',
                            Colors.red,
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            'pageQuestionsBySchoolYear',
                          );
                        }
                      },
                      child: const Text(
                        'Buscar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      );
    });
  }
}
