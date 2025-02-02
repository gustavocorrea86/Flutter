// import 'package:estudamais/models/models.dart';
// import 'package:estudamais/service/service.dart';

// import 'package:estudamais/widgets/animated_button_retangulare.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BoxDiscipline extends StatefulWidget {
//   final String discipline;
//   final String disciplineURL;

//   const BoxDiscipline(this.discipline, this.disciplineURL, {super.key});

//   @override
//   State<BoxDiscipline> createState() => _BoxSchoolyearState();
// }

// class _BoxSchoolyearState extends State<BoxDiscipline> {
//   bool backButton = false;
//   Service service = Service();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ModelPoints>(
//       builder: (context, value, child) {
//         return 
//         AnimatedButtonRetangu(textContent: 'Test', onTap: () {});

//         BoxButton(
//           widget.discipline,
//           100,
//           100,
//           12,
//           fontSizeSecondary: 8,
//           () {
//             if (value.actionBtn) {
//               print(widget.discipline);
//               service.getQuestionsByDiscipline(widget.discipline);
//               for (var q in Service.questionsByDiscipline) {
//                 print(q);
//               }
//             } else {
//               Service.questionsByDiscipline.removeWhere(
//                   (element) => element['displice'] == widget.discipline);
//               print(
//                   'Service.questionsByDiscipline ${Service.questionsByDiscipline}');
//             }
//           },
//         );
//       },
//     );
//   }
// }
