import 'package:estudamais/widgets/box_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

Future result() async {
  print(Service.schoolYearAndSubjects);

  return Service.schoolYearAndSubjects;
}

final Future _future = result();

class _SubjectsState extends State<Subjects> {
  final Service service = Service();

  @override
  Widget build(BuildContext context) {
    bool backButton = false;
    double shadowBox = 10;
    Color colorShadow = Colors.black87;
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '${value.titleDisplice}',
            style: GoogleFonts.aboreto(),
          ),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(129, 255, 255, 255),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    List<Map<String, dynamic>>? subjectsAndSchoolYear =
                        snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData &&
                        subjectsAndSchoolYear != null) {
                      if (subjectsAndSchoolYear.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              ),
                              itemCount: subjectsAndSchoolYear.length,
                              itemBuilder: (context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    backButton = !backButton;
                                    if (backButton) {
                                      print(backButton);
                                      setState(() {
                                        shadowBox = 3;
                                        colorShadow = Colors.white;
                                      });
                                      // Navigator.pushNamed(
                                      //     context, 'pageQuestionsBySchoolYear');
                                    } else {
                                      print(backButton);
                                      setState(() {
                                        shadowBox = 10;
                                        colorShadow = Colors.black87;
                                      });
                                    }
                                  },
                                  child: BoxButton(
                                    subjectsAndSchoolYear[index]['subjects'] ??
                                        'error',
                                    textSecondary: subjectsAndSchoolYear[index]
                                        ['year'],
                                    shadowBox,
                                    100,
                                    100,
                                    20,
                                    colorShadow,
                                  ),
                                );
                              }),
                        );
                      }
                    }
                    return const Center(child: Text("No subjects found."));
                  },
                ),
              ),
            ),
            
          ],
        ),
      );
    });
  }
}
