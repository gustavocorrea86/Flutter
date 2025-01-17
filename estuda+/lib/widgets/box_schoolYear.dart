import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/box_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BoxSchoolyear extends StatelessWidget {
  final String elementarySchool;
  final String schoolYear;
  final String schoolYearURL;
  const BoxSchoolyear(
      this.elementarySchool, this.schoolYear, this.schoolYearURL,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return GestureDetector(
          onTap: () {
            value.titleSchoolYear(schoolYear);
            value.schoolYearUrl(schoolYearURL);
            Navigator.pushNamed(context, 'subjects');
          },
          child: BoxButton(schoolYear, elementarySchool));
      // ),
    });
  }
}
