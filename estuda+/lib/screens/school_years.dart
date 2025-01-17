import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/grid_list.dart';
import 'package:provider/provider.dart';

class SchoolYears extends StatelessWidget {
  const SchoolYears({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, valueStorage, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(valueStorage.titleDisplice, style: GoogleFonts.aboreto(color: Colors.black),),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: GridList(),
            ),
          ],
        ),
      );
    });
  }
}
