import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_ritgh.dart';
import 'package:mongodb_api/widgets/checkbox.dart';
import 'package:mongodb_api/widgets/subject.dart';

class AccumulatedRight extends StatefulWidget {
  const AccumulatedRight({super.key});

  @override
  State<AccumulatedRight> createState() => _AccumulatedRightState();
}

class _AccumulatedRightState extends State<AccumulatedRight> {
  String? dropDownValue;
  String? checkedValue;
  bool? checked = false;
  DaoRight databaseRight = DaoRight();

  @override
  void initState() {
    DaoRight.listQuestions = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acertos acumulados'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('./assets/images/ball-7280265_640.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: const Color.fromARGB(188, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: DaoRight.materias.length,
                          itemBuilder: (_, int index) {
                            return CheckboxWidget(DaoRight.materias[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: DaoRight.assuntos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Subject(DaoRight.questionsForSubject[index],
                          DaoRight.assuntos[index]);
                    }),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black45,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Card(
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton2<String>(
                //         iconStyleData: const IconStyleData(
                //           icon: Icon(
                //             Icons.arrow_drop_down,
                //             weight: 5,
                //           ),
                //           iconSize: 40,
                //         ),
                //         isExpanded: true,
                //         dropdownStyleData: DropdownStyleData(
                //           padding: const EdgeInsets.all(8.0),
                //           width: 350,
                //           offset: Offset.zero,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //         menuItemStyleData: const MenuItemStyleData(height: 50),
                //         hint: const Row(
                //           children: [
                //             Padding(
                //               padding: EdgeInsets.all(8.0),
                //               child: Text('Busca por assunto'),
                //             )
                //           ],
                //         ),
                //         items: DaoRight.assuntos
                //             .map(
                //               (String itens) => DropdownMenuItem(
                //                 value: itens,
                //                 child: Text(itens),
                //               ),
                //             )
                //             .toList(),
                //         value: dropDownValue,
                //         onChanged: (String? item) {
                //           setState(
                //             () {
                //               dropDownValue = item;
                //               print(dropDownValue);
                //               DaoRight().findForSubject(dropDownValue!);
                //             },
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Divider(
                //     color: Colors.black45,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
