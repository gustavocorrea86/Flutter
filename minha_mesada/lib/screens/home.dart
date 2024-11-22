import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:minha_mesada/controller/counter_errors.dart';
import 'package:minha_mesada/controller/counter_points.dart';
import 'package:minha_mesada/database/dao_ritgh.dart';
import 'package:minha_mesada/database/dao_wrong.dart';
import 'package:minha_mesada/models/models.dart';
import 'package:minha_mesada/service/service.dart';
import 'package:minha_mesada/widgets/box_resum.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future? _future;

  @override
  void initState() {
    _future = Service().getDisplice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
          'Ensino Fundamental 1 - 5ª série',
          style: GoogleFonts.aboreto(
            fontSize: 15,
            color: Colors.white,
            shadows: <Shadow>[
              const Shadow(
                offset: Offset(0, 1),
                blurRadius: 4.0,
                color: Colors.black,
              ),
            ],
          ),
        )),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Header'),
              ),
              ListTile(
                title: Text(
                  'Matemática',
                  style: GoogleFonts.robotoFlex(fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(context, 'math');
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Português',
                  style: GoogleFonts.robotoFlex(fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
              Divider(),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.topRight,
                        child: RichText(
                          text: TextSpan(
                            text: 'Total de questões respondidas: ',
                            style: GoogleFonts.aboreto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                            children: [
                              TextSpan(
                                text: value.countAnswered,
                                style: GoogleFonts.aboreto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        )),
                  ),
                  BoxResum(
                    value.pointsDb,
                    'Acertos Acumulados',
                    Lottie.asset('./assets/lotties/coins3.json'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'accumulatedRight');
                        DaoRight.listQuestionsRight.clear();
                      },
                      child: Text(
                        'Detalhes',
                        style: GoogleFonts.roboto(color: Colors.white),
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
                        child: Text(
                          'Detalhes',
                          style: GoogleFonts.roboto(color: Colors.white),
                        )),
                  ),
                  BoxResum(
                    value.pointsDb,
                    'Acertos do Mês',
                    Lottie.asset('./assets/lotties/coins2_animated.json'),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Detalhes',
                          style: GoogleFonts.roboto(color: Colors.white),
                        )),
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
                        child: Text(
                          'Detalhes',
                          style: GoogleFonts.roboto(color: Colors.yellow),
                        )),
                  ),
                  BoxResum(
                    value.errorsDb,
                    'Erros do Mês',
                    Lottie.asset('./assets/lotties/alert.json'),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Detalhes',
                          style: GoogleFonts.roboto(color: Colors.yellow),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'pages');
                        value.pointsHits('0');
                        value.answered(false);
                        value.actBoxAnswered(0);
                        CounterPoints.points = 0;
                        CounterErrors.errors = 0;
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
                          child: Text('Iniciar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
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