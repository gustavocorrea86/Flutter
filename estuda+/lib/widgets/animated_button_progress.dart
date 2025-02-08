import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/show_subjects.dart';
import 'package:estudamais/widgets/box_subjects.dart';
import 'package:flutter/material.dart';

class AnimatedButtonProgress extends StatefulWidget {
  String discipline;
  List<Map<String, dynamic>> listMap;

  AnimatedButtonProgress(
      {required this.discipline, required this.listMap, super.key});

  @override
  State<AnimatedButtonProgress> createState() => _AnimatedButtonProgressState();
}

class _AnimatedButtonProgressState extends State<AnimatedButtonProgress> {
  double paddingLeft1 = 10.0;
  double paddingLeft2 = 25.0;
  double paddingRight1 = 10.0;
  double paddingRight2 = 25.0;
  bool enable = false;
  bool enableCheck = false;
  QuestionsCorrects questionsCorrectsDb = QuestionsCorrects();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(
              left: enable ? paddingLeft1 : paddingLeft2,
              right: enable ? paddingRight1 : paddingRight2,
              top: 2.0,
              bottom: 2.0),
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                offset: Offset(0.0, 2.0),
                spreadRadius: 2.0,
                color: Colors.black12,
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: enable ? Colors.indigo : Colors.blueGrey,
          ),
          child: ListTile(
            onTap: () {
              ShowSubjects().showSubjectsAndSchoolyeaAll(
                  widget.discipline, widget.listMap);
              setState(() {
                enable = !enable;
              });
            },
            //leading: Text(legthSubject),
            title: Text(
              widget.discipline,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),

        Visibility(
          visible: enable,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: ShowSubjects.mapListSubAndYear.length,
            itemBuilder: (context, int index) {
              return BoxSubjectsAndSchoolYear(
                subject: ShowSubjects.mapListSubAndYear[index]['subjects'],
                schoolYear: ShowSubjects.mapListSubAndYear[index]['schoolYear'],
              );
            },
          ),
        ),

        // FutureBuilder(
        //   future: questionsCorrectsDb
        //       .showSubjectsAndSchoolyeaCorrects(widget.discipline),
        //   builder: (context, snapshot) {
        //     //List<Map<String, dynamic>>? listMap = snapshot.data;
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     } else if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasData) {
        //         if (QuestionsCorrects.mapListSubAndYearCorrects.isNotEmpty) {
        //           return Visibility(
        //             visible: enable,
        //             child: ListView.builder(
        //               shrinkWrap: true,
        //               itemCount:
        //                   QuestionsCorrects.mapListSubAndYearCorrects.length,
        //               itemBuilder: (context, int index) {
        //                 return BoxSubjectsAndSchoolYear(
        //                   subject: QuestionsCorrects
        //                       .mapListSubAndYearCorrects[index]['subjects'],
        //                   schoolYear: QuestionsCorrects
        //                       .mapListSubAndYearCorrects[index]['schoolYear'],
        //                 );
        //               },
        //             ),
        //           );
        //         }
        //       }
        //     }
        //     return SizedBox.shrink();
        //   },
        // )
      ],
    );
  }
}

showSubjects(bool enable, List<Map<String, dynamic>> listMap, String subjetc,
    String schoolYear) {
  return Visibility(
    visible: enable,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: listMap.length,
      itemBuilder: (context, int index) {
        return BoxSubjectsAndSchoolYear(
          subject: subjetc,
          schoolYear: schoolYear,
        );
      },
    ),
  );
}

// showMessage(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Questões'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Text('Deseja visualizar as questões?'),
//               Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Não')),
//                   TextButton(onPressed: () {}, child: const Text('Sim'))
//                 ],
//               )
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
