import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/animated_button_circle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxSchoolyear extends StatefulWidget {
  final String elementarySchool;
  final String schoolYear;
  final String schoolYearURL;

  const BoxSchoolyear(
      this.elementarySchool, this.schoolYear, this.schoolYearURL,
      {super.key});

  @override
  State<BoxSchoolyear> createState() => _BoxSchoolyearState();
}

class _BoxSchoolyearState extends State<BoxSchoolyear> {
  bool backButton = false;
  Service service = Service();

  @override
  void initState() {
    Provider.of<ModelPoints>(context, listen: false).actionBtnCircle = false;
    Service.listSelectedSchoolYear.clear();
    print(
        'Service.listSelectedSchoolYear do ${Service.listSelectedSchoolYear}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(
      builder: (context, value, child) {
        return
            //BoxButton(textPrimary, widthButton, heightButton, fontSizePrimary, onTap)
            AnimatedButtonCircle(
          widget.schoolYear,
          textSecondary: widget.elementarySchool,
          100,
          100,
          20,
          fontSizeSecondary: 8,
          () {
            if (value.actionBtnCircle) {
              service.getSubjectsAndSchoolYearOfDiscipline(widget.schoolYear);
              Service().findSubjectsBySchoolYears(widget.schoolYear);
              for (var q in Service.questionsBySchoolYear) {
                print(q);
              }
            } else {
              Service.questionsBySchoolYear.removeWhere(
                  (element) => element['schoolYear'] == widget.schoolYear);
              print(Service.questionsBySchoolYear);

              Service.schoolYearAndSubjects
                  .removeWhere((el) => el['schoolYear'] == widget.schoolYear);
            }
          },
        );
      },
    );
  }
}
