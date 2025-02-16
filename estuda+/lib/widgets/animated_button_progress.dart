// import 'package:estudamais/models/models.dart';
// import 'package:estudamais/service/questions_corrects.dart';
// import 'package:estudamais/service/show_subjects.dart';
// import 'package:estudamais/widgets/box_subjects.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AnimatedButtonProgress extends StatefulWidget {
//   final String discipline;
//   final List<Map<String, dynamic>> listMap;
  

//   const AnimatedButtonProgress(
//       {required this.discipline,
//       required this.listMap,
      
//       super.key});

//   @override
//   State<AnimatedButtonProgress> createState() => _AnimatedButtonProgressState();
// }

// class _AnimatedButtonProgressState extends State<AnimatedButtonProgress> {
//   double paddingLeft1 = 10.0;
//   double paddingLeft2 = 25.0;
//   double paddingRight1 = 10.0;
//   double paddingRight2 = 25.0;
//   bool enable = false;

//   QuestionsCorrects questionsCorrectsDb = QuestionsCorrects();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ModelPoints>(
//       builder: (context, value, child) {
//         return Column(
//           children: [
//             AnimatedContainer(
//               margin: EdgeInsets.only(
//                   left: enable ? paddingLeft1 : paddingLeft2,
//                   right: enable ? paddingRight1 : paddingRight2,
//                   top: 2.0,
//                   bottom: 2.0),
//               duration: const Duration(milliseconds: 180),
//               decoration: BoxDecoration(
//                 boxShadow: const <BoxShadow>[
//                   BoxShadow(
//                     offset: Offset(0.0, 2.0),
//                     spreadRadius: 2.0,
//                     color: Colors.black12,
//                     blurRadius: 4.0,
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(5),
//                 color: enable ? Colors.indigo : Colors.blueGrey,
//               ),
//               child: ListTile(
//                 minTileHeight: 5,
//                 onTap: () {
                 
//                   ShowSubjects().showSubjectsAndSchoolyeaAll(
//                       widget.discipline, widget.listMap);
//                   setState(() {
//                     enable = !enable;
//                   });
//                 },
//                 title: Text(
//                   widget.discipline,
//                   style: const TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: ShowSubjects.mapListSubAndYear.length,
//               itemBuilder: (context, int index) {
//                 return Visibility(
//                   visible: enable,
//                   child: BoxSubjectsAndSchoolYear(
//                     subject: ShowSubjects.mapListSubAndYear[index]['subjects'],
//                     schoolYear: ShowSubjects.mapListSubAndYear[index]
//                         ['schoolYear'],
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

