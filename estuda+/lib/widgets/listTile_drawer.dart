import 'package:estudamais/service/service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estudamais/models/models.dart';
import 'package:provider/provider.dart';

class ListTileDrawer extends StatelessWidget {
  final String discipline;
  final String disciplineURL;
  ListTileDrawer(this.discipline, this.disciplineURL, {super.key});
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return ListTile(
        title: Text(
          discipline,
          style: GoogleFonts.robotoFlex(fontSize: 20),
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          print(disciplineURL);
          service.getQuestionsByDiscipline(disciplineURL);
          Navigator.pushNamed(context, 'schoolYears');
          value.displiceUrl(disciplineURL);

          value.titleDisp(discipline);
          //Service.listQuestionsByDipliceAndSchoolYear.clear();
          Service.resultQuestionsBySubjectsAndSchoolYear.clear();
          Service.schoolYearAndSubjects.clear();
          value.actionBtnCircle = false;
          value.progressError = false;
          value.displiceURL = '';
        },
      );
    });
  }
}
