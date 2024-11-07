import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_ritgh.dart';

class Test extends StatelessWidget {
  Test({super.key});
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: DaoRight.assuntos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text(DaoRight.questionsForSubject[index]),
              title: Text(DaoRight.assuntos[index]),
            );
          }),
    );
  }
}


// class AccumulatedMonth extends StatefulWidget {
//   const AccumulatedMonth({super.key});

//   @override
//   State<AccumulatedMonth> createState() => AccumulatedMonthState();
// }

// class AccumulatedMonthState extends State<AccumulatedMonth> {
//   final List<String> items = [
//     'Item1',
//     'Item2',
//     'Item3',
//     'Item4',
//     'Item5',
//     'Item6',
//     'Item7',
//     'Item8',
//   ];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2<String>(
//             isExpanded: true,
//             hint: const Row(
//               children: [
//                 Icon(
//                   Icons.list,
//                   size: 16,
//                   color: Colors.yellow,
//                 ),
//                 SizedBox(
//                   width: 4,
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Select Item',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.yellow,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             items: items
//                 .map((String item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ))
//                 .toList(),
//             value: selectedValue,
//             onChanged: (String? value) {
//               setState(() {
//                 selectedValue = value;
//                 print(selectedValue);
//               });
//             },
//             buttonStyleData: ButtonStyleData(
//               height: 50,
//               width: 160,
//               padding: const EdgeInsets.only(left: 14, right: 14),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(
//                   color: Colors.black26,
//                 ),
//                 color: Colors.redAccent,
//               ),
//               elevation: 2,
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_forward_ios_outlined,
//               ),
//               iconSize: 14,
//               iconEnabledColor: Colors.yellow,
//               iconDisabledColor: Colors.grey,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               maxHeight: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Colors.redAccent,
//               ),
//               offset: const Offset(-20, 0),
//               scrollbarTheme: ScrollbarThemeData(
//                 radius: const Radius.circular(40),
//                 thickness: WidgetStateProperty.all<double>(6),
//                 thumbVisibility: WidgetStateProperty.all<bool>(true),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 40,
//               padding: EdgeInsets.only(left: 14, right: 14),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
