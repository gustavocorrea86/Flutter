import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/animated_button_progress.dart';
import 'package:estudamais/widgets/animated_button_retangulare.dart';
import 'package:estudamais/widgets/button_progress.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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

  final Future _future = Service().getDisplice();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'home');
                Service.questionsByDiscipline.clear();
                Service.questionsBySchoolYear.clear();
                print(
                    'Service.questionsByDiscipline ${Service.questionsByDiscipline}');
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Disciplinas',
            style: GoogleFonts.aboreto(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
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
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        List<String>? listDiscipline = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          );
                        } else if (snapshot.hasData && listDiscipline != null) {
                          if (listDiscipline.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: listDiscipline.length,
                              itemBuilder: (context, int index) {
                                return AnimatedButtonRectangular(
                                  title: listDiscipline[index],
                                  onTap: () {
                                    if (value.actionBtnRetangulare) {
                                      service.getQuestionsByDiscipline(
                                          listDiscipline[index]);
                                      heightButtonNext = 50;
                                      for (var q
                                          in Service.questionsByDiscipline) {
                                        print(q);
                                      }
                                    } else {
                                      Service.questionsByDiscipline.removeWhere(
                                          (element) =>
                                              element['displice'] ==
                                              listDiscipline[index]);
                                      heightButtonNext = 0;
                                      print(Service.questionsByDiscipline);
                                    }
                                  },
                                );
                              },
                            );
                          }
                        }
                        return const Text('Sem dados');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'schoolYear');
                    },
                    child: const Text('Próximo'),
                  ),
                ),
                //  ButtonProgress((){
                //   Navigator.pushNamed(context, 'schoolYears');
                //  })
              ],
            ),
          ],
        ),
      );
    });
  }
}
