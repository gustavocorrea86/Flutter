import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/box_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BoxSchoolyear extends StatefulWidget {
  final String elementarySchool;
  final String schoolYear;
  final String schoolYearURL;
  double shadowBox;
  Color shadowColor;

  BoxSchoolyear(this.elementarySchool, this.schoolYear, this.schoolYearURL,
      this.shadowBox, this.shadowColor,
      {super.key});

  @override
  State<BoxSchoolyear> createState() => _BoxSchoolyearState();
}

class _BoxSchoolyearState extends State<BoxSchoolyear> {
  bool backButton = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return GestureDetector(
        onTap: () {
          backButton = !backButton;
          print(backButton);
          if (backButton) {
            setState(() {
              widget.shadowBox = 3;
              widget.shadowColor = Colors.white;
              print('adicionou ${widget.schoolYear}');
              Service().findSubjectsBySchoolYears(widget.schoolYear);
            });
          } else {
            setState(() {
              widget.shadowBox = 10;
              widget.shadowColor = Colors.black87;
              print('retirou ${widget.schoolYear}');
              
              Service.schoolYearAndSubjects.removeWhere((el)=> el['year'] == widget.schoolYear);
              print(Service.schoolYearAndSubjects);
            });
          }
        },
        //   value.titleSchoolYear(widget.schoolYear);
        //   value.schoolYearUrl(widget.schoolYearURL);
        //   Future.delayed(const Duration(seconds: 1)).then((value) {
        //     Navigator.pushNamed(context, 'subjects');
        //   });
        child: BoxButton(
            widget.schoolYear,
            textSecondary: widget.elementarySchool,
            widget.shadowBox,
            100,
            100,
            20,
            widget.shadowColor),
      );
    });
  }
}
