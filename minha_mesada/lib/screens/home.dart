import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minha_mesada/database/dao_ritgh.dart';
import 'package:minha_mesada/database/dao_wrong.dart';
import 'package:minha_mesada/models/models.dart';
import 'package:minha_mesada/widgets/box_resum.dart';
import 'package:minha_mesada/widgets/screen_questions.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kids Cash'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.countAnswered,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Header'),
              ),
              ListTile(
                leading: const Icon(Icons.manage_history),
                title: const Text('Matemática'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, 'elementary_school');
                },
              ),
              ListTile(
                leading: const Icon(Icons.manage_history),
                title: const Text('Português'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BoxResum(
                    value.pointsDb,
                    'Acertos Acumulados',
                    Lottie.asset('./assets/lotties/coins3.json'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'accumulatedRight');
                        DaoRight.listQuestionsRight.clear();
                      },
                      child: const Text(
                        'Detalhes',
                        style: TextStyle(
                          color: Colors.white,
                          // shadows: [
                          //   Shadow(
                          //     color: Colors.black,
                          //     offset: Offset(0, 1.0),
                          //     blurRadius: 1.0,
                          //   ),
                          // ],
                        ),
                      ),
                    ),
                  ),
                  BoxResum(
                    'R\$ ${value.pointsDb},00',
                    'Mesada do Mês',
                    Lottie.asset('./assets/lotties/cash2_animated.json'),
                    TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, 'accumulatedMonth');
                        },
                        child: const Text('Detalhes')),
                  ),
                  BoxResum(
                    value.pointsDb,
                    'Acertos do Mês',
                    Lottie.asset('./assets/lotties/coins2_animated.json'),
                    TextButton(onPressed: () {}, child: const Text('Detalhes')),
                  ),
                  BoxResum(
                    value.errorsDb,
                    'Erros Acumulados',
                    Lottie.asset('./assets/lotties/coins_grey_animated.json'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'accumulatedWrongs');
                          DaoWrong.listQuestionsWrongs.clear();
                        },
                        child: const Text('Detalhes')),
                  ),
                  BoxResum(
                    value.errorsDb,
                    'Erros do Mês',
                    Lottie.asset('./assets/lotties/alert.json'),
                    TextButton(onPressed: () {}, child: const Text('Detalhes')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'pages');
                        value.pointsHits('0');
                        value.answered(false);
                        value.actBoxAnswered(0);
                        Counter.countPoints = 0;
                        Counter.countErrors = 0;
                        // DaoUserResum().findAll();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 199, 199, 199),
                                Colors.indigo,
                                Color.fromARGB(255, 68, 96, 255)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black54,
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  blurStyle: BlurStyle.outer
                                  //offset: Offset(0.0, 2.0),
                                  )
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Iniciar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'initial');
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ],
        ),
      );
      //Row(
      //   children: [
      //     ElevatedButton(
      //       onPressed: () {

      //       },
      //       child: const Text('Pages'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, 'initial');
      //       },
      //       child: const Text('Tela inicial'),
      //     ),
      //     ElevatedButton(
      //         onPressed: () {
      //           DaoUserResum().delete();
      //         },
      //         child: const Text('Deletar pontos'))
      //   ],
      // ));
    });
  }
}

// Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             child: FutureBuilder(
//               future: _future,
//               builder: (context, snapshot) {
//                 List? perguntas = snapshot.data;
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(),
//                         Text('Carregando...')
//                       ],
//                     ),
//                   );
//                 } else if (snapshot.hasData && perguntas != null) {
//                   return ListView.builder(
//                     itemCount: perguntas.length,
//                     itemBuilder: (context, index) {
//                       // print(perguntas[2]);

//                       return Text(perguntas[index]);
//                     },
//                   );
//                 }
//                 return Center(child: Text('Nenhuma pergunta cadastrada'));
//               },
//             ),
//           ),