import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:provider/provider.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${value.titleDisplice} - ${value.titleSchoolYears}'),
        ),
        body: FutureBuilder(
          future: service.findSubjectsBySchoolYear(
              value.displiceURL, value.schoolYearURL),
          builder: (context, snapshot) {
            List<String>? listSubjects = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && listSubjects != null) {
              if (listSubjects.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0),
                      itemCount: listSubjects.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print(listSubjects[index]);
                            Navigator.pushNamed(
                                context, 'pageQuestionsBySchoolYear');
                            value.subjectSelect(listSubjects[index]);
                          },
                          child: Container(
                            //padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(183, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 4, color: Colors.indigo),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                )
                              ],
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(listSubjects[index]),
                            ),
                          ),
                        );
                      }),
                );
              }
            }
            return const Center(child: Text("No subjects found."));
          },
        ),
      );
    });
  }
}
