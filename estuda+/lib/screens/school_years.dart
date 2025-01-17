import 'package:estudamais/service/service.dart';
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
          title: Text(
            valueStorage.titleDisplice,
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450,
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
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GridList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        print(Service.schoolYearAndSubjects);
                        Navigator.pushNamed(context, 'subjects');
                      },
                      child: Text('Buscar')),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
