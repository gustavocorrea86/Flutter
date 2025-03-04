import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/screens/home/home.dart';
import 'package:estudamais/screens/schoolYears/school_years.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/animated_button_retangulare.dart';
import 'package:estudamais/widgets/background.dart';
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
                //Navigator.pushNamedAndRe
                Service.questionsByDiscipline.clear();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Disciplinas',
            style: GoogleFonts.aboreto(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
           const Background(),
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Selecione a disciplina:',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                                  (el) => el == Service.listDisciplines[index]);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (Service.questionsByDiscipline.isEmpty) {
                        showSnackBar(
                            context,
                            'Selecione uma disciplina para continuar.',
                            Colors.red);
                      } else {
                        Routes().pushRoute(context, const SchoolYears());
                      }
                    },
                    child: const Text('Próximo'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
