// import 'package:estudamais/screens/loading_next_page.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:estudamais/database/dao_user_resum.dart';
// import 'package:estudamais/models/models.dart';
// import 'package:provider/provider.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   double noRegister = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ModelPoints>(builder: (context, value, child) {
//       return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 5,
//           backgroundColor: Colors.black,
//         ),
//         body: ListView(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.indigoAccent, Colors.white54],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       width: 300,
//                       height: 300,
//                       child: Lottie.asset(
//                           './assets/lotties/animation_login.json')),
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                               label: Text(
//                             'Email',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           )),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: TextFormField(
//                           decoration: const InputDecoration(
//                             label: Text(
//                               'Senha',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           //Navigator.pushNamed(context, 'loadingNextPage');
//                           Navigator.push(
//                               context, MaterialPageRoute(builder: (context){
//                                 return const LoadingNextPage(msgPrimary: 'Aguardando informações', msgSecundary: 'Carregando questões',);
//                               }));
//                           if (DaoUserResum.table == []) {
//                             print('Nenhum registro encontrado');
//                           } else {
//                             print('registro encontrado');
//                           }
//                         },
//                         child: const Text('Entrar'),
//                       ),
//                       SizedBox(
//                         height: noRegister,
//                         child: const Text('Nenhum cadastro encontrado!'),
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             Navigator.pushNamed(context, 'userRegister');
//                           },
//                           child: const Text('Cadastre-se'))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
