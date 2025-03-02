// import 'package:flutter/material.dart';
// import 'package:estudamais/database/dao_user_resum.dart';

// class UserRegister1 extends StatefulWidget {
//   const UserRegister1({super.key});

//   @override
//   State<UserRegister1> createState() => _UserRegisterState();
// }

// class _UserRegisterState extends State<UserRegister1> {
//   String dropDownValue = '';
//   DateTime currentYears = DateTime.now();
//   String currentAge = '';
//   DaoUserResum database = DaoUserResum();
//   final TextEditingController _name = TextEditingController();
//   final TextEditingController _lastName = TextEditingController();

//   final TextEditingController _keyword = TextEditingController();

//   final TextEditingController _step = TextEditingController();
//   List<String> schoolYear = [
//     '1º Ano - Fundamental 1',
//     '2º Ano - Fundamental 1',
//     '3º Ano - Fundamental 1',
//     '4º Ano - Fundamental 1',
//     '5º Ano - Fundamental 1',
//     '6º Ano - Fundamental 2',
//     '7º Ano - Fundamental 2',
//     '8º Ano - Fundamental 2',
//     '9º Ano - Fundamental 2',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Cadastro'),
//         ),
//         body: Column(
//           children: [
//             //DragTarget(builder: ),
//             Draggable(
//               feedback: Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//               ),
//               childWhenDragging: Container(
//                 width: 300,
//                 height: 400,
//                 color: Colors.blueGrey,
//               ),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 color: Colors.amber,
//                 //child: Container(width: 300, height: 400, color: Colors.green,),
//               ),
//             ),
//           ],
//         )

        // ListView(
        //   children: [
        //     Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: MediaQuery.of(context).size.height,
        //       decoration: const BoxDecoration(
        //           gradient: LinearGradient(
        //               begin: Alignment.topLeft,
        //               end: Alignment.bottomRight,
        //               colors: <Color>[
        //             Color.fromARGB(255, 253, 226, 184),
        //             Colors.orange,
        //           ])),
        //       child: Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: TextFormField(
        //               controller: _name,
        //               decoration: const InputDecoration(
        //                 hintText: 'Nome',
        //                 label: Text('Nome'),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: TextFormField(
        //               controller: _lastName,
        //               decoration: const InputDecoration(
        //                 label: Text('Sobrenome'),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //               padding: const EdgeInsets.all(15.0),
        //               child: Container(
        //                 child: DropdownButtonFormField(
        //                     decoration: const InputDecoration(
        //                         label: Text('Nível escolar')),
        //                     items: schoolYear.map<DropdownMenuItem<String>>(
        //                       (String value) {
        //                         return DropdownMenuItem<String>(
        //                           value: value,
        //                           child: Text(value),
        //                         );
        //                       },
        //                     ).toList(),
        //                     onChanged: (String? item) {
        //                       setState(() {
        //                         dropDownValue = item!;
        //                       });
        //                     }),
        //               )),
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: TextFormField(
        //               controller: _keyword,
        //               decoration: const InputDecoration(
        //                 label: Text('Palavra chave'),
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: TextFormField(
        //               decoration: const InputDecoration(
        //                 label: Text('Confirmar palavra chave'),
        //               ),
        //             ),
        //           ),
        //           ElevatedButton(
        //             onPressed: () {
        //               // DaoUserResum().insertPoints('0');
        //               Navigator.pushNamed(context, 'login');
        //               database.insertUser(
        //                 ModelsUserResum(
        //                   name: _name.text,
        //                   lastName: _lastName.text,
        //                   schoolYear: dropDownValue,
        //                   totalPoints: '0',
        //                   totalOfQuestions: '0',
        //                   totalError: '0',
        //                   idQuestions: '0',
        //                   keyword: _keyword.text,
        //                   idQuestionCorrect: '0',
        //                   idQuestionIncorrect: '0',
        //                 ),
        //               );
        //             },
        //             child: const Text('Cadastrar'),
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
//         );
//   }
// }
