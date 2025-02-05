import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/listSelected_scrollable.dart';
import 'package:estudamais/widgets/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/gridList_schoolYear.dart';
import 'package:provider/provider.dart';
//import 'package:progress_button/progress_button.dart';

class SchoolYears extends StatefulWidget {
  const SchoolYears({super.key});

  @override
  State<SchoolYears> createState() => _SchoolYearsState();
}

class _SchoolYearsState extends State<SchoolYears> {
  Color? colorFindError;
  String? textFindError;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, 'discipline');
                Service.questionsByDiscipline.clear();
                Service.questionsBySchoolYear.clear();
                Service.listSelectedDisciplines.clear();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Ano escolar',
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
                ListSelectedDisciplines(
                  list: Service.listSelectedDisciplines,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 20,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Selecione o Ano escolar:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 20,
                      maxHeight: MediaQuery.of(context).size.height / 2),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(129, 255, 255, 255),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        )
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GridListSchoolYear(),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (Service.questionsBySchoolYear.isEmpty) {
                        showSnackBar(
                          context,
                          'Selecione o ano escolar para continuar.',
                          Colors.red,
                        );
                      }else{
                        Navigator.pushNamed(context, 'subject');
                      }
                    },
                    child: const Text('Próximo')),
                // ButtonProgress(actionButton:() {
                //   if (Service.listQuestionsByDipliceAndSchoolYear.isNotEmpty) {
                //     Navigator.pushNamed(context, 'subject');
                //   } else {
                //     value.progressError = true;
                //   }
                // }),
              ],
            ),
          ],
        ),
      );
    });
  }
}
