import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/screens/home/home.dart';
import 'package:estudamais/screens/schoolYears/school_years.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/animated_button_retangulare.dart';
import 'package:estudamais/widgets/background.dart';
import 'package:estudamais/widgets/button_next.dart';
import 'package:estudamais/widgets/show_snackBar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estudamais/models/models.dart';

import 'package:provider/provider.dart';
//import 'package:progress_button/progress_button.dart';

class Discipline extends StatefulWidget {
  const Discipline({super.key});

  @override
  State<Discipline> createState() => _DisciplineState();
}

class _DisciplineState extends State<Discipline> {
  Color? colorFindError;
  String? textFindError;
  bool enable = false;
  Service service = Service();
  double heightButtonNext = 0;

  // @override
  // void initState() {
  //   print('Service.resultController ${Service.resultController}');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Routes().popRoutes(context, const HomeScreen());
                  Service.questionsByDiscipline.clear();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            title: Text(
              'Disciplinas',
              style: GoogleFonts.aboreto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Stack(
            children: [
              Background(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Selecione a disciplina:',
                          style: GoogleFonts.aboreto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.black38,
                              )
                            ]),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Service.listDisciplines.length,
                          itemBuilder: (context, int index) {
                            return AnimatedButtonRectangular(
                              title: Service.listDisciplines[index],
                              fontSizeTitle: 22,
                              textDirection: MainAxisAlignment.center,
                              onTap: () {
                                if (value.actionBtnRetangulare) {
                                  // service.getSchoolYearByDisciplines(
                                  //     Service.listDisciplines[index]);
                                  service.getQuestionsByDiscipline(
                                      Service.listDisciplines[index]);
                                  heightButtonNext = 50;
                                } else {
                                  Service.questionsByDiscipline.removeWhere(
                                      (element) =>
                                          element['displice'] ==
                                          Service.listDisciplines[index]);
                                  heightButtonNext = 0;
                                  //print(Service.questionsByDiscipline);
                                  Service.listSelectedDisciplines.removeWhere(
                                      (el) =>
                                          el == Service.listDisciplines[index]);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: GestureDetector(
              onTap: () {
                if (Service.questionsByDiscipline.isEmpty) {
                  showSnackBar(context,
                      'Selecione uma disciplina para continuar.', Colors.red);
                } else {
                  Routes().pushRoute(context, const SchoolYears());
                }
              },
              child: const ButtonNext(
                textContent: 'Próximo',
              )));
    });
  }
}
