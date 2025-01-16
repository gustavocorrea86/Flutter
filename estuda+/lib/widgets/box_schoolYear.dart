import 'package:estudamais/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxSchoolyear extends StatelessWidget {
  final String schoolYear;
  final String schoolYearURL;
  const BoxSchoolyear(this.schoolYear, this.schoolYearURL,
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTile(
              footer: const Text('Teste'),
              child: Text(schoolYear),
            ),
          ),
        ),
      );
    });
  }
}
