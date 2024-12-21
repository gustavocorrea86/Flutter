import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/service.dart';
import 'package:provider/provider.dart';

class Subjects extends StatefulWidget {
  final BuildContext? context;
  const Subjects({this.context,super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final Service service = Service();
  // final Future _future = Service().findSubjectsByYear(Provider.of<ModelPoints>().displiceURL, Provider.of<ModelPoints>(context!, listen: false).schoolYearURL);
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(value.titleDisplice),
        ),
        body: FutureBuilder(
          future: service.findSubjectsByYear(value.displiceURL, value.schoolYearURL),
          builder: (context, snapshot) {
            List<String>? listSubjects = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.hasData && listSubjects != null) {
              if (listSubjects.isNotEmpty) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0),
                    itemCount: listSubjects.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        //padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(183, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 4, color: Colors.indigo),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              )
                            ]),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(listSubjects[index]),
                        ),
                      );
                    });
              }
            }
            return Center(child: const Text("No subjects found."));
          },
        ),
      );
    });
  }
}
