// import 'package:estudamais/service/questions_corrects.dart';
// import 'package:flutter/material.dart';

// class DropdownFilter extends StatefulWidget {
//   final String subjects;
//   List<String> listOptions;
//   final String schoolYear;

//   DropdownFilter(this.subjects, this.listOptions, this.schoolYear, {super.key});
//   @override
//   State<DropdownFilter> createState() => _DropdownFilterState();
// }

// class _DropdownFilterState extends State<DropdownFilter> {
//   QuestionsCorrects questionsCorrectsDb = QuestionsCorrects();
//   List<String> items = [];
//   @override
//   void initState() {
//     super.initState();
//     //Service().getSeries();
//   }

//   String? selectValue;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
//         child: DropdownButtonFormField<String>(
//           onTap: () {
//             questionsCorrectsDb.getListSchoolYearCorrects(widget.subjects);
//             print(widget.subjects);
//           },
//           decoration: const InputDecoration(
//               //helper: Text('ola'),
//               //isCollapsed: true,
//               //border: UnderlineInputBorder(),
//               //filled: true,
//               ),
//           borderRadius: BorderRadius.circular(20),
//           hint: Text(widget.subjects),
//           onChanged: (x) {
//             // questionsCorrectsDb.showSubjectsAndSchoolyear(
//             //     widget.discipline, widget.subjects);
//           },
//           items: QuestionsCorrects.listSchoolYearsCorrects
//               .map(
//                 (el) => DropdownMenuItem(
//                   value: el,
//                   child: StatefulBuilder(
//                     builder: (context, state) {
//                       return SizedBox(
//                        width: 200,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount:
//                               QuestionsCorrects.listSchoolYearsCorrects.length,
//                           itemBuilder: (context, int index) {
//                             return ListTile(
//                               leading: Checkbox(
//                                 value: items.contains(el),
//                                 onChanged: (isSelected) {
//                                   if (isSelected == true) {
//                                     items.add(el);
//                                     print(el);
//                                   } else {
//                                     items.remove(el);
//                                   }
//                                   state(() {});
//                                   setState(() {});
//                                 },
//                               ),
//                               title: Text(QuestionsCorrects
//                                   .listSchoolYearsCorrects[index]),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               )
//               .toList(),
//         )

//         // DropdownButtonHideUnderline(
//         //   child: DropdownButton2<String>(
//         //     dropdownStyleData: DropdownStyleData(
//         //       decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.circular(20),
//         //       ),
//         //     ),
//         //     isExpanded: true,
//         //     hint: Text(widget.hintText),
//         //     items: widget.options
//         //         .map((String item) => DropdownMenuItem(
//         //               value: item,
//         //               child: Text(item),
//         //             ))
//         //         .toList(),
//         //     value: selectValue,
//         //     onChanged: (String? value) {
//         //       setState(() {
//         //         selectValue = value;
//         //         //Service().findSubjectsBySerie(value!);
//         //       });
//         //       print(selectValue);
//         //     },
//         //     buttonStyleData: ButtonStyleData(
//         //       padding: EdgeInsets.symmetric(horizontal: 10),
//         //       height: 40,
//         //       decoration: BoxDecoration(
//         //         color: Colors.white,
//         //         borderRadius: BorderRadius.circular(20),
//         //       ),
//         //     ),
//         //     menuItemStyleData: const MenuItemStyleData(
//         //       height: 40,
//         //     ),
//         //   ),
//         // ),
//         );
//   }
// }
