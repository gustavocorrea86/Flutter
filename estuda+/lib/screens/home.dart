import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/button_progress.dart';
import 'package:estudamais/widgets/dashbord_displice.dart';
import 'package:estudamais/widgets/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/box_resum.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double shadowBox = 10;
  Service service = Service();
  final Future _future = Service().getQuestions();
  QuestionsCorrects questionsCorrects = QuestionsCorrects();
  QuestionsIncorrects questionsIncorrects = QuestionsIncorrects();
  bool? enable;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                Service.questionsByDiscipline.clear();
                Service.resultQuestionsBySubjectsAndSchoolYear.clear();
                Service.schoolYearAndSubjects.clear();
                //value.displiceURL = '';
              },
              icon: const Icon(Icons.menu),
            );
          }),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topRight,
              child: RichText(
                text: TextSpan(
                  text: 'Total de questões respondidas: ',
                  style: GoogleFonts.aboreto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(
                      text: value.countAnswered,
                      style: GoogleFonts.aboreto(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Header'),
              ),
              ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Disciplinas'),
                  trailing: const Icon(Icons.arrow_circle_right),
                  onTap: () {
                    Navigator.pushNamed(context, 'discipline');

                    service.getDisplice();
                  }),

              //ListTileDrawer('Ciências da Natureza', 'ciencias'),
              // const Divider(),
              // ListTileDrawer('Matemática', 'matematica'),
              // const Divider(),
              // ListTileDrawer('Língua Portuguesa', 'portugues'),
              // const Divider(),
              // ListTileDrawer('Geografia', 'geografia'),
              // const Divider(),
              // ListTileDrawer('História', 'historia'),
              // const Divider(),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Visibility(
              visible: enable ?? false,
              child: const LinearProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  BoxResum(
                    value.pointsDb,
                    'Acertos Totais',
                    Lottie.asset('./assets/lotties/Animation_correct.json'),
                    TextButton(
                      onPressed: () {
                        if (QuestionsCorrects
                            .resultQuestionsCorrect.isNotEmpty) {
                          // CHAMA A CONSULTA PARA OBTER AS DISCIPLINAS RESPONDIDAS CORRETAMENTE
                          questionsCorrects.getDisciplineOfQuestionsCorrects();
                          //questionsCorrects.getQuestionsCorrects();
                          Navigator.pushNamed(context, 'accumulatedRight');
                        } else {
                          showSnackBar(context,
                              'Aguarde o carregamento inicial.', Colors.red);
                        }
                      },
                      child: Text(
                        'Resumo',
                        style: GoogleFonts.roboto(color: Colors.yellow),
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      DashbordDisplice(
                          'Ciências da Natureza', Colors.green, 0.10, 10),
                      DashbordDisplice('Matemática', Colors.green, 0.50, 233),
                      DashbordDisplice(
                          'Língua Portuguesa', Colors.green, 0.100, 44),
                      DashbordDisplice('Geografia', Colors.green, 0.30, 5030),
                      DashbordDisplice('História', Colors.green, 0.40, 90),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: BoxResum(
                      value.errorsDb,
                      'Erros Totais',
                      Lottie.asset('./assets/lotties/alert.json'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'accumulatedWrongs');
                            // questionsIncorrects
                            //     .getDisciplineOfQuestionsIncorrects();
                                // questionsIncorrects.getQuestionsIncorrects();
                          },
                          child: Text(
                            'RESUMO',
                            style: GoogleFonts.roboto(color: Colors.yellow),
                          )),
                    ),
                  ),
                  const Column(
                    children: [
                      DashbordDisplice(
                          'Ciências da Natureza', Colors.red, 0.005, 122),
                      DashbordDisplice('Matemática', Colors.red, 0.010, 600),
                      DashbordDisplice(
                          'Língua Portuguesa', Colors.red, 0.20, 12),
                      DashbordDisplice('Geografia', Colors.red, 0.300, 999),
                      DashbordDisplice('História', Colors.red, 0.40, 2),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FutureBuilder(
                        future: _future,
                        builder: (context, snapshot) {
                          List<ModelQuestions>? listQuestions = snapshot.data;
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const Text('Estabelecendo conexão...');
                            case ConnectionState.waiting:
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasData && listQuestions != null) {
                                service.getDisplice();
                                questionsCorrects.getQuestionsCorrects();
                                questionsIncorrects.getQuestionsIncorrects();
                                print(' enable = false;');
                                if (listQuestions.isNotEmpty) {
                                  return ButtonProgress(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, 'discipline');
                                    },
                                  );
                                } else {
                                  value.progressError = false;
                                }
                              }
                            case ConnectionState.active:
                              return const SizedBox();
                          }
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Ops, algo deu errado.\nNão consegui buscar os dados.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                              ),
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'discipline');
                      },
                      child: const Text('discipline')),
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

// BoxResum(
                    //   'R\$ ${value.pointsDb},00',
                    //   'Mesada do Mês',
                    //   Lottie.asset('./assets/lotties/cash2_animated.json'),
                    //   TextButton(
                    //       onPressed: () {
                    //         // Navigator.pushNamed(context, 'accumulatedMonth');
                    //       },
                    //       child: Text(
                    //         'Detalhes',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       )),
                    // ),
                    // BoxResum(
                    //   value.pointsDb,
                    //   'Acertos do Mês',
                    //   Lottie.asset('./assets/lotties/Animation _Allwrongs.json'),
                    //   TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         'Detalhes',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       )),
                    // ),
                    // BoxResum(
                    //   value.errorsDb,
                    //   'Erros Acumulados',
                    //   Lottie.asset('./assets/lotties/Animation _Allwrongs.json'),
                    //   TextButton(
                    //       onPressed: () {
                    //         Navigator.pushNamed(context, 'accumulatedWrongs');
                    //         DaoWrong.listQuestionsWrongs.clear();
                    //       },
                    //       child: Text(
                    //         'Detalhes',
                    //         style: GoogleFonts.roboto(color: Colors.yellow),
                    //       )),
                    // ),

// ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, 'discipline');
                    //   },
                    //   child: Text('Iniciar'),
                    // ),

                    // AnimatedButtonRectangular(title: 'Iniciar', onTap: (){
                    //   Navigator.pushNamed(context, 'discipline');
                    // }),

                    // AnimatedButtonCircle('Iniciar', 88, 80, 15, () {
                    //    Navigator.pushNamed(context, 'discipline');
                    //   value.pointsHits('0');
                    //   value.answered(false);
                    //   value.actBoxAnswered(0);
                    //   CounterPoints.points = 0;
                    //   CounterErrors.errors = 0;
                    //   Future.delayed(const Duration(seconds: 1)).then((value) {

                    //   });
                    // }),